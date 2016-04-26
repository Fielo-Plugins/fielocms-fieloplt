public with sharing class RedemptionView {
	public class ViewReflectionDefault implements ViewInterface {

    public ApexPages.Component getComponent(Component__c c, Object data, ComponentsEnabled__c compReference){
        if(OrganizationUtil.showComponent(compReference.Visibility__c)){
            if(c.ComponentReference__c == 'ShoppingCart'){
	            List<sObject> dataRecords = (List<sObject>)data;
	            List<Field> fieldSet = OrganizationUtil.getFieldsStructure(c, compReference.sObject__c);
	            Component.ShoppingCart shoppingCart = new Component.ShoppingCart(config = c, recordSet = dataRecords, fieldSet = fieldSet, compSettings = compReference);
	            ApexPages.Component listComponent = getListComponent(c, data, compReference);
	            attachListSubComponents(c, fieldSet, listComponent);
	            shoppingCart.childComponents.add(listComponent);
	            return shoppingCart;
	        }
        }

        return null;
    }

    public void attachListSubComponents(Component__c config, List<Field> fieldset, ApexPages.Component component){
        List<ApexPages.Component> componentsList = new List<ApexPages.Component>();
        for(Field field : fieldset){
            ApexPages.Component listField = getListField(config.Layout__c, field);

            //subcomponent
            if(field.type == 'SubComponent'){
                if(field.reflectionClass != null){
                    Type t = Type.forName(field.reflectionClass);
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

        if(field.apiName == 'AddToCart'){
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
        }

        return null;
    }
}