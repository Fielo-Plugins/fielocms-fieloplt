/**
* @author Diego Amarante
* @date 09/06/2015
* @description
*/
public with sharing class DataReflectionDefault implements DataInterface{

    /**
    * @description Method to get the data on execution
    * @date 28/04/2015 47948936
    * @param List<Component__c> components
    * @return Map<Id, List<sObject>>
    **/
    public Map<Id, Object> getBulkData(List<Component__c> components){
        Site__c program = SiteUtil.getSiteProgram(new List<String>{'RewardView__c','NewsView__c','CustomPage__c', 'ShoppingCart__c'});
        Map<String,ComponentLibrary__c> compSettingsMap = DataUtil.getComponentsEnabledMap(components);
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(Component__c c : components){
            if(c.ComponentLibrary__c != null){
                if(OrganizationUtil.showComponent(compSettingsMap.get(c.ComponentLibrary__c).Visibility__c)){
                    if(c.Limit__c == null)
                        c.Limit__c = 5;

                    if(c.ComponentLibrary__r.Name == 'Banner'){
                        List<String> fieldSet = OrganizationUtil.getFieldSet(c.FieldSet__c);
                        if(c.ComponentLibrary__r.LinkField__c != null){
                            fieldSet = OrganizationUtil.getJoinedList(fieldSet,new List<String>{c.ComponentLibary__r.LinkField__c});
                        }
                        newMapData.put(c.Id, BannerData.getBanners(fieldSet, program.Id, c.Id, null, null, c.Limit__c.intValue(), 0, c.OrderBy__c));
                    }else if(c.ComponentLibrary__r.Name == 'BannerWidget'){
                        List<String> fieldSet = OrganizationUtil.getFieldSet(c.FieldSet__c);
                        if(c.ComponentLibrary__r.LinkField__c != null){
                            fieldSet = OrganizationUtil.getJoinedList(fieldSet,new List<String>{.ComponentLibary__r.LinkField__c});
                        }
                        newMapData.put(c.Id, BannerData.getBanners(fieldSet, program.Id, c.Id, c.Tag__c, c.Category__c, c.Limit__c.intValue(), 0, c.OrderBy__c));
                    }else if(c.ComponentLibrary__r.Name == 'Badges'){
                        newMapData.put(c.Id, getBadges(OrganizationUtil.getFieldSet(c.FieldSet__c), program.Id, c.Limit__c.intValue(), 0, c.OrderBy__c));
                    }else if(c.ComponentLibrary__r.Name == 'Branches'){
                        newMapData.put(c.Id, FrontEndUtil.getBranches(OrganizationUtil.getFieldSet(c.FieldSet__c), c.Limit__c.intValue(), 0, c.OrderBy__c));
                    }else if(c.ComponentLibrary__r.Name == 'Catalog'){
                        newMapData.put(c.Id, RewardData.getRewards(OrganizationUtil.getFieldSet(c.FieldSet__c), program.Id, null, c.Category__c != null ? new List<Id>{c.Category__c} : null, c.Tag__c, c.Limit__c.intValue(), 0, c.OrderBy__c, c.FilterBySegment__c));
                    }else if(c.ComponentLibrary__r.Name == 'FilterByCategories'){
                        newMapData.put(c.Id, CategoryData.getCategories(OrganizationUtil.getFieldSet(c.FieldSet__c), c.Category__c, program.Id, c.Limit__c.intValue(), 0));
                    }else if(c.ComponentLibrary__r.Name == 'FilterByTags'){
                        newMapData.put(c.Id, TagData.getTags(OrganizationUtil.getFieldSet(c.FieldSet__c), c.Tag__c, program.Id, c.Limit__c.intValue(), 0, c.OrderBy__c));
                    }else if(c.ComponentLibrary__r.Name == 'ContentFeed'){
                        newMapData.put(c.Id, ContentFeedData.getNews(OrganizationUtil.getFieldSet(c.FieldSet__c), c.Id, null, null, null, c.Limit__c.intValue(), 0, c.OrderBy__c));
                    }else if(c.ComponentLibrary__r.Name == 'ContentFeedWidget'){
                        newMapData.put(c.Id, ContentFeedData.getNews(OrganizationUtil.getFieldSet(c.FieldSet__c), c.Id, null, c.Tag__c, c.Category__c, c.Limit__c.intValue(), 0, c.OrderBy__c));
                    }else if(c.ComponentLibrary__r.Name == 'GetPoints'){
                        newMapData.put(c.Id, new Transaction__c());
                    }else if(c.ComponentLibrary__r.Name == 'Register'){
                        newMapData.put(c.Id, new Member__c());
                    }else if(c.ComponentLibrary__r.Name == 'MemberDetail' || c.ComponentLibrary__r.Name == 'Account'){
                        newMapData.put(c.Id, MemberUtil.getLoggedMember(new List<String>{'Name', 'FirstName__c', 'LastName__c', 'Email__c', 'Points__c'}));
                    }else if(c.ComponentLibrary__r.Name == 'Transactions'){
                        newMapData.put(c.Id, TransactionData.getTransactions(OrganizationUtil.getFieldSet(c.FieldSet__c), null, null, null, c.Limit__c.intValue(), 0, null, c.OrderBy__c));
                    }else if(c.ComponentLibrary__r.Name == 'Navigation'){
                        List<String> fieldSet = OrganizationUtil.getFieldSet(c.FieldSet__c);
                        if(c.ComponentLibrary__r.LinkField__c != null){
                            fieldSet = OrganizationUtil.getJoinedList(fieldSet,new List<String>{c.ComponentLibary__r.LinkField__c});
                        }
                        newMapData.put(c.Id, getNavigations(c.Navigation__c, fieldSet, program.Id));
                    }else if(c.ComponentLibrary__r.Name == 'Redemptions'){
                        String whereCondition = 'Redemption__r.Status__c != \'Open\' AND Redemption__r.Member__c = \'' + MemberUtil.getMemberId() + '\'';
                        Id redemptionId = c.RecordId__c;
                        if(redemptionId != null){
                            whereCondition += ' AND Redemption__c = \'' + redemptionId + '\'';
                        }
                        Set<String> fields = new Set<String>();
                        for(String s : OrganizationUtil.getFieldSet(c.FieldSet__c)){
                            fields.add(s);
                        }
                        newMapData.put(c.Id, RedemptionData.getRedemptionItems(fields, null, null, null, c.Limit__c.intValue(), 0, whereCondition, c.OrderBy__c));
                    }else if(c.ComponentLibrary__r.Name == 'NavigationDetail'){
                        newMapData.put(c.Id, NavigationData.getCurrentNavigation());
                    }else if(c.ComponentLibrary__r.Name == 'RedemptionDetail'){
                        Id redemptionId = c.RecordId__c;
                        if(redemptionId != null){
                            newMapData.put(c.Id, RedemptionUtil.getRedemption(redemptionId, OrganizationUtil.getFieldSet(c.FieldSet__c)));
                        }else{
                            newMapData.put(c.Id, RedemptionUtil.getRedemptionRecord(MemberUtil.getLoggedMember(null), 'FrontEnd'));
                        }
                    }else if(c.ComponentLibrary__r.Name == 'RewardDetail'){
                        Id rewardId = c.RecordId__c;
                        List<Reward__c> rewards = RewardData.getRewards(OrganizationUtil.getFieldSet(c.FieldSet__c), program.Id, ' Id = \'' + rewardId + '\'', null, null, 1, 0, null, null);
                        newMapData.put(c.Id, (!rewards.isEmpty() ? rewards[0] : null));
                    }else if(c.ComponentLibrary__r.Name == 'ContentFeedDetail'){
                        Id newsId = c.RecordId__c;
                        List<News__c> news = ContentFeedData.getNews(OrganizationUtil.getFieldSet(c.FieldSet__c), null, ' Id = \'' + newsId + '\'', null, null, 1, 0, null);
                        newMapData.put(c.Id, (!news.isEmpty() ? news[0] : null));
                    }else if(c.ComponentLibrary__r.Name == 'RegisterStep2'){
                        Id memberId = c.RecordId__c;
                        newMapData.put(c.Id, MemberUtil.getAllFieldsMember(memberId));
                    }else if(c.ComponentLibrary__r.Name == 'ShoppingCart'){
                        Redemption__c redemption = RedemptionUtil.getRedemptionRecord(MemberUtil.getLoggedMember(null), 'FrontEnd');
                        String whereCondition;
                        if(redemption.Id != null){
                            whereCondition = ' Redemption__c = \'' + redemption.Id + '\'';
                        }else{
                            whereCondition = ' Redemption__c = null';
                        }
                        List<RedemptionItem__c> redItems = RedemptionData.getRedemptionItems(new Set<String>{'Id','Reward__c'}, null, null, null, c.Limit__c.intValue(), 0, whereCondition, c.OrderBy__c);
                        if(redItems.size() > 0){
                            whereCondition = ' Id in (';
                            for(RedemptionItem__c ri : redItems){
                                whereCondition += '\'' + ri.Reward__c + '\',';
                            }
                            whereCondition = whereCondition.subStringBeforeLast(',');
                            whereCondition += ')';
                        }else{
                            whereCondition = ' Id = null';
                        }
                        newMapData.put(c.Id, RewardData.getRewards(OrganizationUtil.getFieldSet(c.FieldSet__c), program.Id, whereCondition, null, null, null, 0, null, null));
                    }
                }
            }
        }
        return newMapData;
    }

    public List<sObject> getData(Component__c component, Integer pageNumber, String orderBy, String filters){
        //Set Category or Tag from FilterBy
        String categoryId;
        String tagId;
        if(filters != null){
            Map<String,Object> filtersMap = (Map<String,Object>) JSON.deserializeUntyped(filters);
            for(String s : filtersMap.keySet()){
                if(s == 'Category__c'){
                    categoryId = (String)filtersMap.get(s);
                }else if(s == 'Tag__c'){
                    tagId = (String)filtersMap.get(s);
                }
            }
        }

        String locale = 'EN';//OrganizationUtil.getLanguage();
        Site__c program = SiteUtil.getSiteProgram(new List<String>{'RewardView__c','NewsView__c','CustomPage__c', 'ShoppingCart__c'});
        List<SObject> newData = new List<SObject>();

        //Prepare all the queries
        if(component.ComponentLibrary__c != null){
            if(component.Limit__c == null)
                component.Limit__c = 5;

            //Calculate the offset from the Page Number
            Integer offset = Integer.valueOf(component.Limit__c * (pageNumber - 1));

            if(component.ComponentLibrary__r.Name == 'Banner'){
                List<sObject> aux = BannerData.getBanners(OrganizationUtil.getFieldSet(component.FieldSet__c), program.Id, component.Id, component.Tag__c, component.Category__c, Integer.valueOf(component.Limit__c), offset, orderBy);
                newData.addAll(aux);

            }else if(component.ComponentLibrary__r.Name == 'BannerWidget'){
                //newMapData.put(c.Id, FrontEndUtil.getBanners(OrganizationUtil.getFieldSet(c.FieldSet__c), program.Id, c.Id, c.Tag__c, c.Category__c, c.Limit__c.intValue(), 0));
                if(component.Category__c != null){
                    categoryId = component.Category__c;
                }
                if(component.Tag__c != null){
                    tagId = component.Tag__c;
                }
                List<sObject> aux = BannerData.getBanners(OrganizationUtil.getFieldSet(component.FieldSet__c), program.Id, component.Id, tagId, categoryId, Integer.valueOf(component.Limit__c), offset, orderBy);
                newData.addAll(aux);

            }else if(component.ComponentLibrary__r.Name == 'Badges'){
                List<sObject> aux = getBadges(OrganizationUtil.getFieldSet(component.FieldSet__c), program.Id, Integer.valueOf(component.Limit__c), offset, orderBy);
                newData.addAll(aux);
            }else if(component.ComponentLibrary__r.Name == 'Branches'){
                List<sObject> aux = FrontEndUtil.getBranches(OrganizationUtil.getFieldSet(component.FieldSet__c), Integer.valueOf(component.Limit__c), offset, orderBy);
                newData.addAll(aux);
            }else if(component.ComponentLibrary__r.Name == 'Catalog'){

                List<String> categoriesIds = new List<String>();
                system.debug(categoryId);
                if(categoryId != null && categoryId != ''){
                    categoryId = categoryId.replace('(', '');
                    categoryId = categoryId.replace(')', '');
                    categoriesIds.add(categoryId);
                }
                system.debug(tagId);
                system.debug(categoryId);
                system.debug(categoriesIds);
                List<sObject> aux = RewardData.getRewards(OrganizationUtil.getFieldSet(component.FieldSet__c), program.Id, null, categoriesIds, tagId, Integer.valueOf(component.Limit__c), offset, orderBy, component.FilterBySegment__c);
                newData.addAll(aux);
            /*}else if(component.ComponentLibrary__r.Name == 'Categories'){
                List<sObject> aux = FrontEndUtil.getCategories(new List<String>(), null);
                newData.addAll(aux);
*/
            }else if(component.ComponentLibrary__r.Name == 'ContentFeed'){
                //FrontEndUtil.getNews(List<String> fields, Id componentId, String whereConditionQuery, Id tag, Id category, Integer quantity, Integer offset, String order){
                system.debug('component.Id ' + component.Id + ' tagId ' + tagId + ' categoryId ' + categoryId);
                List<sObject> aux = ContentFeedData.getNews(OrganizationUtil.getFieldSet(component.FieldSet__c), component.Id, null, tagId, categoryId, component.Limit__c.intValue(), offset, orderBy);
                newData.addAll(aux);
            }else if(component.ComponentLibrary__r.Name == 'ContentFeedWidget'){
                //FrontEndUtil.getNews(List<String> fields, Id componentId, String whereConditionQuery, Id tag, Id category, Integer quantity, Integer offset, String order)
                //newMapData.put(c.Id, FrontEndUtil.getNews(OrganizationUtil.getFieldSet(c.FieldSet__c), c.Id, null, c.Tag__c, c.Category__c, c.Limit__c.intValue(), 0, null));
                if(component.Category__c != null){
                    categoryId = component.Category__c;
                }
                if(component.Tag__c != null){
                    tagId = component.Tag__c;
                }

                system.debug('component.Id ' + component.Id + ' tagId ' + tagId + ' categoryId ' + categoryId);
                List<sObject> aux = ContentFeedData.getNews(OrganizationUtil.getFieldSet(component.FieldSet__c), component.Id, null, tagId, categoryId, component.Limit__c.intValue(), offset, orderBy);
                newData.addAll(aux);

            //}else if(component.ComponentLibrary__r.Name == 'Content'){
            //}else if(component.ComponentLibrary__r.Name == 'Menu'){
            //}else if(component.ComponentLibrary__r.Name == 'Profile'){
            }else if(component.ComponentLibrary__r.Name == 'Transactions'){
                List<sObject> aux = TransactionData.getTransactions(OrganizationUtil.getFieldSet(component.FieldSet__c), null, null, null, component.Limit__c.intValue(), offset, null, orderBy);
                newData.addAll(aux);
            }else if(component.ComponentLibrary__r.Name == 'Navigation'){
                List<sObject> aux = getNavigations(component.Navigation__c, OrganizationUtil.getFieldSet(component.FieldSet__c), program.Id);
                newData.addAll(aux);
            }else if(component.ComponentLibrary__r.Name == 'Redemptions'){
                String whereCondition = 'Redemption__r.Status__c = \'Close\' AND Redemption__r.Member__c = \'' + MemberUtil.getMemberId() + '\'';
                Id redemptionId = component.RecordId__c;
                if(redemptionId != null){
                    whereCondition += ' AND Redemption__c = \'' + redemptionId + '\'';
                }
                Set<String> fields = new Set<String>();
                for(String s : OrganizationUtil.getFieldSet(component.FieldSet__c)){
                    fields.add(s);
                }
                List<sObject> aux = RedemptionData.getRedemptionItems(fields, null, null, null, component.Limit__c.intValue(), offset, whereCondition, orderBy);
                newData.addAll(aux);
            }
        }
        //Si el valor es nulo cambiarlo por vacio para que el js lo reemplace
        for(sObject element : newData){
            for(String s :  OrganizationUtil.getFieldSet(component.FieldSet__c)){
                if(element.get(s) == null){
                    element.put(s, '');
                }
            }
        }

        return newData;
    }

    private static List<Badge__c> getBadges(List<String> fields, Id programId, Integer quantity, Integer offset, String orderBy){
        List<Badge__c> badgeItems = new List<Badge__c>();
        Set<String> fieldSet = new Set<String>();
        if (fields != null){
            fieldSet.addAll(fields);
        }
        fieldSet.addAll(new Set<String>{'Id', 'Name'});

        String query = 'SELECT ';
        for (String field : fieldSet){
            query += field + ', ';
        }
        query = query.removeEnd(', ');

        Id memberId = MemberUtil.getMemberId();
        Set<Id> badgeIds = new Set<Id>();
        for(BadgeMember__c bm : [Select Badge__c FROM BadgeMember__c WHERE Member__c =: memberId]){
            badgeIds.add(bm.Badge__c);
        }

        query += ' FROM Badge__c WHERE Id In: badgeIds AND Program__c =: programId';

        //LIMIT
        if(quantity != null){
            query += ' LIMIT ' + quantity;
        }

        //OFFSET
        if(offset != null){
            query += ' OFFSET ' + offset;
        }

        //ORDER by
        if(String.isNotBlank(orderBy)){
            query += ' ORDER BY ' + orderBy;
        }

        //return query;
        system.debug('Badges query: '+query);
        badgeItems = database.query(query);
        //MemberUtil.filterSegments(bannerItems, RedemptionUtil.lookForMatchingRedemptionRulesCookie());

        return badgeItems;
    }

    private static List<Navigation__c> getNavigations(Id parentId, List<String> fields, Id programId){
        Set<Id> segNavIds = new Set<Id>();
        for(SegmentDomain__c segDom : [SELECT Navigation__c FROM SegmentDomain__c WHERE Segment__c in : RedemptionUtil.lookForMatchingRedemptionRulesCookie()]){
            segNavIds.add(segDom.Navigation__c);
        }

        String query = 'SELECT Name, CustomURL__c, FormulaURL__c, (SELECT Name, CustomURL__c, FormulaURL__c FROM Navigations__r ORDER BY Order__c) FROM Navigation__c WHERE Parent__c =: parentId AND Program__c =: programId AND (Id in : segNavIds OR HasSegments__c = false) ORDER BY Order__c';
        return Database.query(query);
    }

}