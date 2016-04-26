public with sharing class MemberView implements FieloCMS.ViewInterface{

    public ApexPages.Component getComponent(Component__c c, Object data, ComponentsEnabled__c compReference){
        if(OrganizationUtil.showComponent(compReference.Visibility__c)){
            if(c.ComponentReference__c == 'RegisterStep2'){
	            List<Field> fieldSet = OrganizationUtil.getFieldsStructure(c, compReference.sObject__c);
	            Component.RegisterStep2 register = new Component.RegisterStep2(config = c, fieldSet = fieldSet, compSettings = compReference);
	            if(data != null){
	                register.record = (sObject)data;
	                Component.Form form = new Component.Form(config = c, record = (sObject)data, fieldSet = fieldSet, compSettings = compReference);
	                attachRecordSubComponents(c, fieldSet, form, (sObject)data, compReference.SObject__c);
	                register.childcomponents.add(form);
	            }
	            return register;
	        }else if(c.ComponentReference__c == 'OrganizationMembers'){
	            Member__c loggedMember = new MembersSelector(new Set<String>{'RecordType.DeveloperName'}).selectLoggedMember();
	            if(loggedMember.RecordType.DeveloperName == 'OrganizationAccount'){
	                Component.Apex.PanelGroup panelGroup = new Component.Apex.PanelGroup();
	                panelGroup.childcomponents.add(getListComponent(c, data, compReference));
	                Program__c program = new ProgramsSelector(new Set<String>{'RegisterPage__c'}).selectBySiteUrl();
	                Component.Link link = new Component.Link(url = '/Page?pageId=' + c.MenuRedirect__c + '&retURL=' + ApexPages.currentPage().getUrl());
	                link.childcomponents.add(new Component.Apex.OutputText(value = Label.Invite));
	                panelGroup.childcomponents.add(link);
	                return panelGroup;
	            }

	        }
        }

        return null;
    }

    public void attachSubComponents(Component__c config, List<Field> fieldset, ApexPages.Component component){
        List<ApexPages.Component> componentsList = new List<ApexPages.Component>();
        for(Field field : fieldset){
            //subcomponent
            if(field.type == 'SubComponent'){
                if(field.reflectionClass != null){
                    Type t = Type.forName(field.reflectionClass);
                    ViewInterface rendInstance = (ViewInterface)t.newInstance();
                    ApexPages.Component subComponent = rendInstance.getSubComponent(config, field, null);
                    if(subComponent != null){
                        componentsList.add(subComponent);
                    }
                }
            }
        }
        component.childComponents.addAll(componentsList);
    }

    public void attachRecordSubComponents(Component__c config, List<Field> fieldset, ApexPages.Component component, SObject record, String sObjectName){
        List<ApexPages.Component> componentsList = new List<ApexPages.Component>();
        for(Field field : fieldset){
            ApexPages.Component recordField = getRecordField(config.Layout__c, field, record, config);
            //subcomponent
            if(field.type == 'SubComponent'){
                if(field.reflectionClass != null){
                    Type t = Type.forName(field.reflectionClass);
                    ViewInterface rendInstance = (ViewInterface)t.newInstance();
                    ApexPages.Component subComponent = rendInstance.getSubComponent(config, field, record);
                    if(subComponent != null){
                        recordField.childcomponents.add(subComponent);
                    }
                }
            }else if(field.type == 'Multimedia'){
                if(field.apiName == 'Image'){
                    Component.Image image = new Component.Image();
                    image.record = record;
                    image.field = field;
                    recordField.childComponents.add(image);
                }
            }else{
                system.debug('readonly: ' + field.apiName + ':' + field.readOnly);
                if(config.Layout__c == 'Detail' || config.Layout__c == 'Detail/Edit' || field.readOnly){
                    Component.OutputField outputField = new Component.OutputField();
                    outputField.record = record;
                    outputField.field = field;
                    recordField.childComponents.add(outputField);
                }else if(config.Layout__c == 'Edit'){
                    if(field.type == 'Picklist'){
                        Component.Picklist pickList = new Component.Picklist();
                        pickList.record = record;
                        pickList.field = field;
                        pickList.config = config;
                        recordField.childComponents.add(pickList);
                    }else if(field.type == 'TextArea'){
                        Component.InputTextArea textArea = new Component.InputTextArea();
                        textArea.record = record;
                        textArea.field = field;
                        textArea.config = config;
                        recordField.childComponents.add(textArea);
                    }else{
                        Component.InputField input = new Component.InputField();
                        input.record = record;
                        input.field = field;
                        input.config = config;
                        recordField.childComponents.add(input);
                    }
                }
            }
            componentsList.add(recordField);
        }
        component.childComponents.addAll(componentsList);
    }

    public void attachListSubComponents(Component__c config, List<Field> fieldset, ApexPages.Component component){
        List<ApexPages.Component> componentsList = new List<ApexPages.Component>();
        for(Field field : fieldset){
            ApexPages.Component listField = getListField(config.Layout__c, field);

            //subcomponent
            if(field.type == 'SubComponent'){
                if(field.reflectionClass != null){
                    Type t = Type.forName(field.reflectionClass);
                    system.debug('class: ' + field.reflectionClass);
                    ViewInterface rendInstance = (ViewInterface)t.newInstance();
                    ApexPages.Component subComponent = rendInstance.getSubComponent(config, field, null);
                    if(subComponent != null){
                        listField.childComponents.add(subComponent);
                    }
                }
            }else if(field.type == 'Multimedia'){
                if(field.apiName == 'Image'){
                    Component.Image image = new Component.Image();
                    image.expressions.record = '{!record}';
                    image.field = field;
                    if(!field.linkToDetail){
                        listField.childComponents.add(image);
                    }else{
                        listField.childComponents.add(addLinkToDetail(image, field, config));
                    }
                }
            }else{
                Component.OutputField outputField = new Component.OutputField();
                outputField.expressions.record = '{!record}';
                outputField.field = field;
                //recordField.childComponents.add(outputField);

                /*Component.Apex.OutputText outputText = new Component.Apex.OutputText();
                outputText.expressions.value = '{!record[\''+field.apiName+'\']}';
                outputText.escape = false;              */

                if(!field.linkToDetail){
                    listField.childComponents.add(outputField);
                }else{
                    listField.childComponents.add(addLinkToDetail(outputField, field, config));
                }
            }
            componentsList.add(listField);
        }
        component.childComponents.addAll(componentsList);
    }

    public void attachNavigationSubComponents(Component__c config, List<Field> fieldset, ApexPages.Component component){
        List<ApexPages.Component> componentsList = new List<ApexPages.Component>();
        for(Field field : fieldset){
            if(field.type == 'Multimedia'){
                if(field.apiName == 'Image'){
                    Component.Image image = new Component.Image();
                    image.expressions.record = '{!record}';
                    image.field = field;
                    componentsList.add(image);
                }
            }else{
                Component.Apex.OutputText outputText = new Component.Apex.OutputText();
                outputText.expressions.value = '{!record[\''+field.apiName+'\']}';
                outputText.escape = false;
                componentsList.add(outputText);
            }
        }
        component.childComponents.addAll(componentsList);
    }

    private ApexPages.Component addLinkToDetail(ApexPages.Component component, Field field, Component__c config){
        Component.LinkToDetail linkToDetail = new Component.LinkToDetail();
        linkToDetail.expressions.record = '{!record}';
        linkToDetail.field = field;
        linkToDetail.config = config;
        linkToDetail.childComponents.add(component);
        return linkToDetail;
    }

    private ApexPages.Component getRecordField(String layout, Field field, SObject record, Component__c config){
        if(layout == 'Detail' || layout == 'Detail/Edit'){
            if(config.RecordType.DeveloperName == 'DetailForm'){
                Component.FormViewField formViewField = new Component.FormViewField();
                formViewField.record = record;
                formViewField.field = field;
                formViewField.config = config;
                return formViewField;
            }else if(config.RecordType.DeveloperName == 'Detail'){
                Component.DetailField detailField = new Component.DetailField();
                detailField.record = record;
                detailField.field = field;
                detailField.config = config;
                return detailField;
            }
        }else if(layout == 'Edit'){
            Component.FormField formField = new Component.FormField();
            formField.record = record;
            formField.field = field;
            formField.config = config;
            return formField;
        }
        return null;
    }

    private ApexPages.Component getListField(String layout, Field field){
        if(layout == 'Table'){
            Component.TableField tableField = new Component.TableField();
            tableField.expressions.record = '{!record}';
            tableField.field = field;
            return tableField;
        }else if(layout == 'Slider'){
            Component.SliderField sliderField = new Component.SliderField();
            sliderField.expressions.record = '{!record}';
            sliderField.field = field;
            return sliderField;
        }else if(layout == 'Grid'){
            Component.GridField gridField = new Component.GridField();
            gridField.expressions.record = '{!record}';
            gridField.field = field;
            return gridField;
        }
        return null;
    }

    public ApexPages.Component getSubComponent(Component__c config, Field field, SObject record){

        if(field.apiName == 'Like'){
            Component.Like likeComponent = new Component.Like();
            if(record != null){
                likeComponent.record = record;
            }else{
                likeComponent.expressions.record = '{!record}';
            }
            likeComponent.field = field;
            likeComponent.config = config;
            likeComponent.relatedListName = 'Likes__r';
            return likeComponent;
        }else if(field.apiName == 'Wish'){
            Component.Wish wishComponent = new Component.Wish();
            if(record != null){
                wishComponent.record = record;
            }else{
                wishComponent.expressions.record = '{!record}';
            }
            wishComponent.field = field;
            wishComponent.config = config;
            wishComponent.relatedListName = 'Members_Reward__r';
            return wishComponent;
        }else if(field.apiName == 'Captcha'){
            Component.Captcha captcha = new Component.Captcha();
            if(record != null){
                captcha.record = record;
            }else{
                captcha.expressions.record = '{!record}';
            }
            captcha.field = field;
            captcha.config = config;
            return captcha;
        }else if(field.apiName == 'RegisterFacebook'){
            Component.RegisterFacebook registerFacebook = new Component.RegisterFacebook();
            if(record != null){
                registerFacebook.record = record;
            }else{
                registerFacebook.expressions.record = '{!record}';
            }
            registerFacebook.field = field;
            registerFacebook.config = config;
            return registerFacebook;
        }else if(field.apiName == 'LoginAsMember' || field.apiName == 'LoginAsOrganization'){
            Component.SelectMember selectMember = new Component.SelectMember();
            selectMember.config = config;
            selectMember.field = field;
            selectMember.type = field.apiName == 'LoginAsMember' ? 'Member' : 'Organization';
            if(record != null){
                selectMember.record = record;
            }else{
                selectMember.expressions.record = '{!record}';
            }
            return selectMember;
        }else if(field.apiName == 'ToggleManager'){
            Component.ToggleManager toggleManager = new Component.ToggleManager();
            toggleManager.config = config;
            toggleManager.field = field;
            if(record != null){
                toggleManager.record = record;
            }else{
                toggleManager.expressions.record = '{!record}';
            }
            return toggleManager;
        }else if(field.apiName == 'BlockUnblockMember'){
            Component.BlockUnblockMember blockUnblockMember = new Component.BlockUnblockMember();
            blockUnblockMember.config = config;
            blockUnblockMember.field = field;
            if(record != null){
                BlockUnblockMember.record = record;
            }else{
                BlockUnblockMember.expressions.record = '{!record}';
            }
            return BlockUnblockMember;
        }else if(field.apiName == 'HandleInvitationsMembers'){
            Component.HandleInvitationsMembers handleInvitationsMembers = new Component.HandleInvitationsMembers();
            handleInvitationsMembers.config = config;
            handleInvitationsMembers.field = field;
            if(record != null){
                handleInvitationsMembers.record = record;
            }else{
                handleInvitationsMembers.expressions.record = '{!record}';
            }
            return handleInvitationsMembers;
        }else{
            return new Component.Apex.OutputText(value = 'SubComponent Null');
        }

        return null;
    }
}