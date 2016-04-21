public class ViewReflectionDefault implements ViewInterface {

    public ApexPages.Component getComponent(Component__c c, Object data ){
        if(OrganizationUtil.showComponent(compReference.Visibility__c)){
            //list type
            if( c.RecordType.DeveloperName == 'List' ){
                if(data == null){
                    return null;
                }
                return getListComponent(c, data );
            //navigation type
            }else if(c.RecordType.DeveloperName == 'Filter' || c.RecordType.DeveloperName == 'Navigation'){
                if(data == null){
                    return null;
                }
                return getNavigationComponent(c, data );
            //detail type
            }else if(c.RecordType.DeveloperName == 'Content' || c.RecordType.DeveloperName == 'Detail' || c.RecordType.DeveloperName == 'DetailForm' || c.RecordType.DeveloperName == 'Form' ){
                if(data == null && c.RecordType.DeveloperName != 'Content'){
                    return null;
                }
                return getRecordComponent(c, data );
            //custom types
            }else{
                return getCustomComponent(c, data );
            }
        }

        return null;
    }

    public ApexPages.Component getListComponent(Component__c c, Object data ){
        if(c.Layout__c == 'Table'){
            List<sObject> dataRecords = (List<sObject>)data;
            List<Field> fieldSet = OrganizationUtil.getFieldsStructure(c, c.ComponentLibrary__r.sObject__c);
            Component.Table table = new Component.Table(config = c, recordSet = dataRecords, fieldSet = fieldSet, compSettings = c.ComponentLibrary__r);
            attachListSubComponents(c, fieldSet, table);
            return table;
        }else if(c.Layout__c == 'Grid'){
            List<sObject> dataRecords = (List<sObject>)data;
            List<Field> fieldSet = OrganizationUtil.getFieldsStructure(c, c.ComponentLibrary__r.sObject__c);
            Component.Grid grid = new Component.Grid(config = c, recordSet = dataRecords, fieldSet = fieldSet, compSettings = c.ComponentLibrary__r);
            attachListSubComponents(c, fieldSet, grid);
            return grid;
        }else if(c.Layout__c == 'Slider'){
            List<sObject> dataRecords = (List<sObject>)data;
            List<Field> fieldSet = OrganizationUtil.getFieldsStructure(c, compReference.sObject__c);
            Component.Slider slider = new Component.Slider(config = c, recordSet = dataRecords, fieldSet = fieldSet, compSettings = c.ComponentLibrary__r);
            attachListSubComponents(c, fieldSet, slider);
            return slider;
        }

        return null;
    }

    public ApexPages.Component getNavigationComponent(Component__c c, Object data ){
        if(c.Layout__c == 'Navigation'){
            List<sObject> dataRecords = (List<sObject>)data;
            List<Field> fieldSet = OrganizationUtil.getFieldsStructure(c, c.ComponentLibrary__r.sObject__c);
            Component.Navigation navigation = new Component.Navigation(config = c, recordSet = dataRecords, fieldSet = fieldSet, compSettings = c.ComponentLibrary__r);
            addNavigationStructure(navigation, c, dataRecords, fieldSet, c.ComponentLibrary__r);
            return navigation;
        }

        return null;
    }

    public ApexPages.Component getRecordComponent(Component__c c, Object data){
        if(c.Layout__c == 'Detail' || c.Layout__c == 'Detail/Edit'){
            if(c.RecordType.DeveloperName == 'DetailForm'){
                List<Field> fieldSet = OrganizationUtil.getFieldsStructure(c, c.ComponentLibrary__r.sObject__c);
                Component.FormView formView = new Component.FormView(config = c, record = (sObject)data, fieldSet = fieldSet, compSettings = c.ComponentLibrary__r);
                attachRecordSubComponents(c, fieldSet, formView, (sObject)data, c.ComponentLibrary__r.SObject__c);
                return formView;
            }else if(c.RecordType.DeveloperName == 'Detail'){
                List<Field> fieldSet = OrganizationUtil.getFieldsStructure(c, compReference.sObject__c);
                Component.Detail detail = new Component.Detail(config = c, record = (sObject)data, fieldSet = fieldSet, compSettings = c.ComponentLibrary__r);
                attachRecordSubComponents(c, fieldSet, detail, (sObject)data, c.ComponentLibrary__r.SObject__c);
                return detail;
            }
        }else if(c.Layout__c == 'Edit'){
            List<Field> fieldSet = OrganizationUtil.getFieldsStructure(c, c.ComponentLibrary__r.sObject__c);
            Component.Form form = new Component.Form(config = c, record = (sObject)data, fieldSet = fieldSet, compSettings = c.ComponentLibrary__r);
            attachRecordSubComponents(c, fieldSet, form, (sObject)data, c.ComponentLibrary__r.SObject__c);
            return form;
        }else if(c.Layout__c == 'FreeStyle'){
            List<Field> fieldSet = OrganizationUtil.getFieldsStructure(c, c.ComponentLibrary__r.sObject__c);
            Component.Content container = new Component.Content(config = c, fieldSet = fieldSet, compSettings = c.ComponentLibrary__r);
            replaceDataContent(c, fieldSet, container, (sObject)data);
            return container;
        }else{
            return new Component.Apex.OutputText(value = c.ComponentLibrary__r.Name + 'Component Null');
        }

        return null;
    }

    public ApexPages.Component getCustomComponent(Component__c c, Object data){
        if(c.ComponentLibrary__r.Name == 'Login'){
            List<Field> fieldSet = OrganizationUtil.getFieldsStructure(c.FieldSet__c);
            Component.SiteLoginFielo login = new Component.SiteLoginFielo(config = c);
            attachSubComponents(c, fieldSet, login);
            return login;
/* 
        }
          if(c.ComponentReference__c == 'IncludePage'){
              Component.IncludePage include = new Component.IncludePage(config = c);
              return include;
        }else if(c.ComponentReference__c == 'RegisterStep2'){
            List<Field> fieldSet = OrganizationUtil.getFieldsStructure(c, compReference.sObject__c);
            Component.RegisterStep2 register = new Component.RegisterStep2(config = c, fieldSet = fieldSet, compSettings = compReference);
            if(data != null){
                register.record = (sObject)data;
                Component.Form form = new Component.Form(config = c, record = (sObject)data, fieldSet = fieldSet, compSettings = compReference);
                attachRecordSubComponents(c, fieldSet, form, (sObject)data, compReference.SObject__c);
                register.childcomponents.add(form);
            }
            return register;
        }else if(c.ComponentReference__c == 'ShoppingCart'){
            List<sObject> dataRecords = (List<sObject>)data;
            List<Field> fieldSet = OrganizationUtil.getFieldsStructure(c, compReference.sObject__c);
            Component.ShoppingCart shoppingCart = new Component.ShoppingCart(config = c, recordSet = dataRecords, fieldSet = fieldSet, compSettings = compReference);
            ApexPages.Component listComponent = getListComponent(c, data, compReference);
            attachListSubComponents(c, fieldSet, listComponent);
            shoppingCart.childComponents.add(listComponent);
            return shoppingCart;
        }else if(c.ComponentReference__c == 'OrganizationMembers'){
            Member__c loggedMember = new MembersSelector(new Set<String>{'RecordType.DeveloperName'}).selectLoggedMember();
            if(loggedMember.RecordType.DeveloperName == 'OrganizationAccount'){
                Component.Apex.PanelGroup panelGroup = new Component.Apex.PanelGroup();
                panelGroup.childcomponents.add(getListComponent(c, data, compReference));
                Site__c program = new ProgramsSelector(new Set<String>{'RegisterPage__c'}).selectBySiteUrl();
                Component.Link link = new Component.Link(url = '/Page?pageId=' + c.MenuRedirect__c + '&retURL=' + ApexPages.currentPage().getUrl());
                link.childcomponents.add(new Component.Apex.OutputText(value = Label.Invite));
                panelGroup.childcomponents.add(link);
                return panelGroup;
            }

        }
*/

        return null;
    }

    private void addNavigationStructure(ApexPages.Component navigation, Component__c config, List<SObject> dataRecords, List<Field> fieldset ){
        //first level
        Component.UnorderedList ul = new Component.UnorderedList(config = config, recordSet = dataRecords, fieldSet = fieldSet, compSettings = config.ComponentLibrary__r);
        Component.ListItem li = new Component.ListItem(config = config, fieldSet = fieldSet, compSettings = config.ComponentLibrary__r);
        li.expressions.record = '{!record}';

        //first fieldset
        Component.Link linkRecord = new Component.Link(config = config, fieldSet = fieldSet, compSettings = config.ComponentLibrary__r);
        linkRecord.expressions.record = '{!record}';
        attachNavigationSubComponents(config, fieldset, linkRecord);

        //second level
        Component.UnorderedList ulChild = new Component.UnorderedList(config = config, fieldSet = fieldSet, compSettings = config.ComponentLibrary__r);
        if(compReference.RelatedListName__c != null){
            ulChild.expressions.recordSet = '{!record[\'' + compReference.RelatedListName__c + '\']}';
        }
        Component.ListItem liChild = new Component.ListItem(config = config, fieldSet = fieldSet, compSettings = config.ComponentLibrary__r);
        liChild.expressions.record = '{!record}';

        //second fieldset
        Component.Link linkRecordChild = new Component.Link(config = config, fieldSet = fieldSet, compSettings = config.ComponentLibrary__r);
        linkRecordChild.expressions.record = '{!record}';
        attachNavigationSubComponents(config, fieldset, linkRecordChild);

        liChild.childComponents.add(linkRecordChild);
        ulChild.childComponents.add(liChild);
        List<ApexPages.Component> liList = new List<ApexPages.Component>{linkRecord, ulChild};
        li.childComponents.addAll(liList);
        ul.childComponents.add(li);
        navigation.childComponents.add(ul);
    }

    public void replaceDataContent(Component__c config, List<Field> fieldset, ApexPages.Component component, SObject record){
        if(record != null){
            for(Field field : fieldset){
                //TODO MULTILANGUAGE String apiName = field.multiLanguage ? field.apiName : field.apiName;
                String apiName = field.apiName;
                if(record.get(field.apiName) != null){
                    config.Content__c = config.Content__c.replace('{!' + apiName + '}', String.valueOf(record.get(field.apiName)));
                }else{
                    config.Content__c = config.Content__c.replace('{!' + apiName + '}', '');
                }
            }
        }
        /*Component.Apex.OutputText outputText = new Component.Apex.OutputText();
        outputText.value = config.Content__c;*/
        Component.OutputField outputText = new Component.OutputField();
        outputText.record = config;
        Field field = new Field('Content__c', null);
        field.type = 'textarea';
        outputText.field = field;
        component.childComponents.add(outputText);
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
        }else if(field.apiName == 'AddToCart'){
            Component.AddToCart addToCart = new Component.AddToCart();
            if(record != null){
                addToCart.record = record;
            }else{
                addToCart.expressions.record = '{!record}';
            }
            addToCart.field = field;
            addToCart.config = config;
            addToCart.relatedListName = 'RedemptionItems__r';
            return addToCart;
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
        }else if(field.apiName == 'Tag'){
            Component.Tag tag = new Component.Tag();
            if(record != null){
                tag.record = record;
            }else{
                tag.expressions.record = '{!record}';
            }
            tag.field = field;
            tag.config = config;
            if(config.ComponentLibrary__r.Name == 'Catalog'){
                tag.relatedListName = 'RewardTag__r';
            }else{
                tag.relatedListName = 'TagItems__r';
            }
            return tag;
        }else if(field.apiName == 'ImageUpload'){
            if(config.Layout__c == 'Edit'){
                Component.ImageUpload imgUpload = new Component.ImageUpload();
                if(record != null){
                    imgUpload.record = record;
                }else{
                    imgUpload.expressions.record = '{!record}';
                }
                imgUpload.config = config;
                imgUpload.field = field;
                return imgUpload;
            }else{
                Component.Image image = new Component.Image();
                if(record != null){
                    String url = (String)record.get(field.multimediaField);
                    image.url = url == null ? '': url;
                }else{
                    image.expressions.url = '{!record[\'' + field.multimediaField + '\']}';
                }
                image.field = field;
                image.config = config;
                return image;
            }
        }else if(field.apiName == 'Password' || field.apiName == 'PasswordConfirm'){
            Component.InputPassword pass = new Component.InputPassword();
            pass.config = config;
            pass.field = field;
            if(record != null){
                pass.record = record;
            }else{
                pass.expressions.record = '{!record}';
            }
            return pass;
        }else if(field.apiName == 'ShoppingQuantity'){
            Component.ShoppingQuantity quant = new Component.ShoppingQuantity();
            quant.config = config;
            quant.field = field;
            quant.relatedListName = 'RedemptionItems__r';
            if(record != null){
                quant.record = record;
            }else{
                quant.expressions.record = '{!record}';
            }
            return quant;
        }else if(field.apiName == 'ShoppingTotal'){
            Component.ShoppingTotal total = new Component.ShoppingTotal();
            total.config = config;
            total.field = field;
            total.relatedListName = 'RedemptionItems__r';
            if(record != null){
                total.record = record;
            }else{
                total.expressions.record = '{!record}';
            }
            return total;
        }else if(field.apiName == 'ShoppingDelete'){
            Component.Delete del = new Component.Delete();
            del.config = config;
            del.field = field;
            if(record != null){
                del.record = record;
            }else{
                del.expressions.record = '{!record}';
            }
            return del;
        }/*else if(field.apiName == 'InviteMember'){
            Component.InviteContact invite = new Component.InviteContact();
            invite.config = config;
            invite.field = field;
            if(record != null){
                invite.record = record;
            }else{
                invite.expressions.record = '{!record}';
            }
            return invite;
        }*/



        else if(field.apiName == 'LoginAsMember' || field.apiName == 'LoginAsOrganization'){
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