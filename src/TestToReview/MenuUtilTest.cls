/**
* @author Agustín Gallardo
* @date 11/10/2014
* @description Class to test the MenuUtil
*/
@isTest
private class MenuUtilTest {

    @isTest static void test_method_one() {
        //Create a member, a menu, subMenu, Sections and some components

        /*MockUpFactory.setCustomProperties(false);
        MockUpFactory.setupComponentLibrary();

        Apexpages.currentPage().getParameters().put('parameterMenuTest', 'test');
        //first menu creation
        Page__c menu1 = new Page__c(Name = 'test menu 1', Home__c = true, Visibility__c ='Both', Placement__c = 'Main');
        insert menu1;

        //second menu creation
        Page__c menu2 = new Page__c(Name = 'test menu 2', Home__c = true, Visibility__c ='Both', Placement__c = 'Main');
        insert menu2;

        //first subMenu creation
        Page__c subMenu1 = new Page__c(Name = 'test subMenu 1', Home__c = true, Visibility__c ='Both', Placement__c = 'Main', Page__c = menu1.Id);
        insert subMenu1;

        //second subMenu creation
        Page__c subMenu2 = new Page__c(Name = 'test subMenu 2', Home__c = true, Visibility__c ='Both', Placement__c = 'Main', Page__c = menu2.Id);
        insert subMenu2;

        //first menu sections
        Section__c section1 = new Section__c(Page__c = menu1.Id, Width__c = '12');
        insert section1;
        Section__c section2 = new Section__c(Page__c = menu1.Id, Width__c = '12', Parent__c = section1.Id);
        insert section2;
        Section__c section3 = new Section__c(Page__c = menu1.Id, Width__c = '12', Parent__c = section1.Id);
        insert section3;
        Component__c compBanner1 = new Component__c(Section__c = section2.Id, Page__c = menu1.Id, ComponentReference__c = 'Banner');

        //second menu sections
        Section__c section4 = new Section__c(Page__c = menu2.Id, Width__c = '12');
        insert section4;
        Section__c section5 = new Section__c(Page__c = menu2.Id, Width__c = '12', Parent__c = section4.Id);
        insert section5;
        Section__c section6 = new Section__c(Page__c = menu2.Id, Width__c = '12', Parent__c = section4.Id);
        insert section6;
        Component__c compBanner2 = new Component__c(Section__c = section5.Id, Page__c = menu2.Id, ComponentReference__c = 'Banner');

        //first menu components settings
        compBanner1.Mobile__c = true;
        compBanner1.Tablet__c = false;
        compBanner1.Desktop__c = false;
        insert compBanner1;

        Component__c compNews1 = new Component__c(Section__c = section3.Id, Page__c = menu1.Id, ComponentReference__c = 'ContentFeed');

        compNews1.Mobile__c = true;
        compNews1.Tablet__c = false;
        compNews1.Desktop__c = false;
        insert compNews1;

        //creates a content feed
        News__c news1 = new News__c(Category__c = 'test news 1', Type__c = 'test', isActive__c = true, Component__c = compNews1.Id);
        insert news1;

        //creates a banner
        Banner__c ban1 = new Banner__c(Name = 'testBanner1', Placement__c = 'Home', Component__c = compBanner1.Id);
        insert ban1;

        //creates a banner with the /banner/top.jpg attachment, to simulate mockupBanner
        Banner__c ban2 = new Banner__c(Name = 'testBanner2', Placement__c = 'Home', Component__c = compBanner1.Id, attachmentId__c = '/banner/top.jpg', IsActive__c = true);
        insert ban2;

        //attachs an image to the banner
        Attachment attachment1 = new Attachment();
        attachment1.body = Blob.valueOf( 'this is an attachment test' );
        attachment1.name = 'fake attachment';
        attachment1.parentId = ban1.id;
        insert attachment1;

        //activate the banner
        ban1.AttachmentId__c = attachment1.Id;
        ban1.IsActive__c = true;
        update ban1;

        //second menu components settings
        compBanner2.Mobile__c = true;
        compBanner2.Tablet__c = false;
        compBanner2.Desktop__c = false;
        insert compBanner2;

        Component__c compNews2 = new Component__c(Section__c = section3.Id, Page__c = menu1.Id);

        compNews2.Mobile__c = true;
        compNews2.Tablet__c = false;
        compNews2.Desktop__c = false;
        insert compNews2;

        //creates a content feed
        News__c news2 = new News__c(Category__c = 'test news 2', Type__c = 'test', isActive__c = true, Component__c = compNews2.Id);
        insert news2;

        //creates a banner
        Banner__c ban3 = new Banner__c(Name = 'testBanner3', Placement__c = 'Home', Component__c = compBanner2.Id);
        insert ban3;

        //creates a banner with the /banner/top.jpg attachment, to simulate mockupBanner
        Banner__c ban4 = new Banner__c(Name = 'testBanner4', Placement__c = 'Home', Component__c = compBanner2.Id, attachmentId__c = '/banner/top.jpg', IsActive__c = true);
        insert ban4;

        //attachs an image to the banner
        Attachment attachment2 = new Attachment();
        attachment2.body = Blob.valueOf( 'this is an attachment test' );
        attachment2.name = 'fake attachment';
        attachment2.parentId = ban3.id;
        insert attachment2;

        //activate the banner
        ban3.AttachmentId__c = attachment2.Id;
        ban3.IsActive__c = true;
        update ban3;

        //clone test menu
        menuUtil.cloneMenu(menu1.Id);

        Set<Id> menues = new Set<Id>{menu1.Id, menu2.Id};

        Set<Id> clonedMenues = menuUtil.cloneMenues(menues);

        System.assertEquals(menues.size(), clonedMenues.size());

        //create a memory clone of the first menu
        Page__c menu1Clone = menu1.clone(false, true, false, false);

        //insert the clone
        insert menu1Clone;

        //clone it's childs
        menuUtil.cloneMenuChilds(menu1.Id, menu1Clone.Id);*/
    }

    private static testmethod void exportMenus(){
        MockUpFactory.setCustomProperties(false);
        MockUpFactory.setupComponentLibrary();
        Site__c program = SiteUtil.getDefaultProgram();

        //first menu creation
        Page__c menu = new Page__c(Name = 'test menu 1', Home__c = true, Visibility__c ='Both', Placement__c = 'Main');
        insert menu;
        //first menu sections
        Section__c section = new Section__c(Page__c = menu.Id, Width__c = '12');
        insert section;

        Section__c subSection = new Section__c(Parent__c = section.Id, Width__c = '12');
        insert subSection;

        Map<String,Id> recordTypesMap = new Map<String,Id>();
        String objectName = OrganizationUtil.getPrefixUnderScore()+'Component__c';
        for(RecordType rt : [SELECT Id, DeveloperName FROM RecordType WHERE sObjectType =: objectName]){
            recordTypesMap.put(rt.DeveloperName, rt.Id);
        }

        Component__c componentBanner = new Component__c(Section__c = subSection.Id, Page__c = menu.Id, RecordTypeId = recordTypesMap.get('Banner'), ComponentReference__c = 'Banner');
        Component__c componentNews = new Component__c(Section__c = subSection.Id, Page__c = menu.Id, RecordTypeId = recordTypesMap.get('ContentFeed'), ComponentReference__c = 'ContentFeed');
        insert new List<Component__c>{componentBanner, componentNews};

        Banner__c newBanner = new Banner__c(Name = 'Banner', Component__c = componentBanner.Id);
        insert newBanner;

        News__c news = new News__c(Component__c = componentNews.Id);
        insert news;

        String xml = MenuUtil.exportMenus(program.Id, null, null);
    }

    private static testmethod void importMenus(){
        MockUpFactory.setCustomProperties(false);
        Site__c program = SiteUtil.getDefaultProgram();

        String xml = '';
        xml += '<?xml version="1.0" encoding="UTF-8"?>';
        xml += '<menus bulkMode="true" object="Page__c" type="list">';
        xml += '<menu sourceId="a0Po0000003ce2XEAQ" type="record">';
        xml += '<Order field="Order__c" type="field">16</Order>';
        xml += '<Home field="Home__c" type="field">false</Home>';
        xml += '<Layout field="Layout__c" type="field">One Column</Layout>';
        xml += '<Mobile field="Mobile__c" type="field">true</Mobile>';
        xml += '<ExternalName field="ExternalName__c" type="field">Catalog</ExternalName>';
        xml += '<Placement field="Placement__c" type="field">Main</Placement>';
        xml += '<Tablet field="Tablet__c" type="field">true</Tablet>';
        xml += '<visibility field="visibility__c" type="field">Both</visibility>';
        xml += '<Desktop field="Desktop__c" type="field">true</Desktop>';
        xml += '<sections object="Section__c" type="relatedList">';
        xml += '<section type="record">';
        xml += '<Type field="Type__c" type="field">12</Type>';
        xml += '<sections object="Section__c" type="relatedList">';
        xml += '<section>';
        xml += '<Type field="Type__c" type="field">12</Type>';
        xml += '<components object="Component__c" type="relatedList">';
        xml += '<component type="record">';
        xml += '<Name field="Name" type="field">Banner</Name>';
        xml += '<recordtype type="recordtype">Banner</recordtype>';
        xml += '<Order field="Order__c" type="field">23</Order>';
        xml += '<Width field="Width__c" type="field">0</Width>';
        xml += '<Height field="Height__c" type="field">0</Height>';
        xml += '<Qcolumns field="Qcolumns__c" type="field">1</Qcolumns>';
        xml += '<Paging field="Paging__c" type="field">true</Paging>';
        xml += '<Layout field="Layout__c" type="field">Slider</Layout>';
        xml += '<Modal field="Modal__c" type="field">true</Modal>';
        xml += '<Mobile field="Mobile__c" type="field">true</Mobile>';
        xml += '<Type field="Type__c" type="field">Row</Type>';
        xml += '<Tablet field="Tablet__c" type="field">true</Tablet>';
        xml += '<FilterBySegment field="FilterBySegment__c" type="field">false</FilterBySegment>';
        xml += '<Desktop field="Desktop__c" type="field">true</Desktop>';
        xml += '<banners object="Banner__c" type="relatedList">';
        xml += '<banner type="record">';
        xml += '<Name field="Name" type="field">Banner</Name>';
        xml += '<isActive field="isActive__c" type="field">true</isActive>';
        xml += '<AttachmentId field="AttachmentId__c" type="field">/banner/top.jpg</AttachmentId>';
        xml += '</banner>';
        xml += '</banners>';
        xml += '</component>                            ';
        xml += '</components>';
        xml += '</section>';
        xml += '</sections>';
        xml += '</section>';
        xml += '</sections>';
        xml += '<segments object="SegmentDomain__c" type="relatedList">';
        xml += '<segment type="recordName">Seg2</segment>';
        xml += '<segment type="recordName">Seg1</segment>';
        xml += '</segments>';
        xml += '</menu>';
        xml += '<menu sourceId="a0Po0000003cdAtEAI" type="record">';
        xml += '<Order field="Order__c" type="field">8</Order>';
        xml += '<Home field="Home__c" type="field">false</Home>';
        xml += '<Layout field="Layout__c" type="field">One Column</Layout>';
        xml += '<Mobile field="Mobile__c" type="field">true</Mobile>';
        xml += '<ExternalName field="ExternalName__c" type="field">Content feed</ExternalName>';
        xml += '<Placement field="Placement__c" type="field">Main</Placement>';
        xml += '<Tablet field="Tablet__c" type="field">true</Tablet>';
        xml += '<visibility field="visibility__c" type="field">Both</visibility>';
        xml += '<Desktop field="Desktop__c" type="field">true</Desktop>';
        xml += '<sections object="Section__c" type="relatedList">';
        xml += '<section type="record">';
        xml += '<Type field="Type__c" type="field">12</Type>';
        xml += '<sections object="Section__c" type="relatedList">';
        xml += '<section>';
        xml += '<Type field="Type__c" type="field">12</Type>';
        xml += '<components object="Component__c" type="relatedList">';
        xml += '<component type="record">';
        xml += '<recordtype type="recordtype">News</recordtype>';
        xml += '<FieldSet2 field="FieldSet2__c" type="field">Title__c,Body__c</FieldSet2>';
        xml += '<Order field="Order__c" type="field">11</Order>';
        xml += '<FieldSet field="FieldSet__c" type="field">Title__c,PublishDate__c</FieldSet>';
        xml += '<Width field="Width__c" type="field">0</Width>';
        xml += '<Height field="Height__c" type="field">0</Height>';
        xml += '<Display field="Display__c" type="field">Modal</Display>';
        xml += '<Qcolumns field="Qcolumns__c" type="field">4</Qcolumns>';
        xml += '<Paging field="Paging__c" type="field">true</Paging>';
        xml += '<Qant field="Qant__c" type="field">8</Qant>';
        xml += '<Layout field="Layout__c" type="field">Grid</Layout>';
        xml += '<Modal field="Modal__c" type="field">true</Modal>';
        xml += '<Mobile field="Mobile__c" type="field">true</Mobile>';
        xml += '<Qrows field="Qrows__c" type="field">2</Qrows>';
        xml += '<Tablet field="Tablet__c" type="field">true</Tablet>';
        xml += '<FilterBySegment field="FilterBySegment__c" type="field">false</FilterBySegment>';
        xml += '<Desktop field="Desktop__c" type="field">true</Desktop>';
        xml += '<news object="News__c" type="relatedList">';
        xml += '<new type="record">';
        xml += '<QuantityLikes field="QuantityLikes__c" type="field">0</QuantityLikes>';
        xml += '<QuantityComments field="QuantityComments__c" type="field">0</QuantityComments>';
        xml += '<Body field="Body__c" type="field">&lt;p&gt;&lt;span style=&quot;color: #ff9900;&quot;&gt;esto es una fiesta&lt;/span&gt;&lt;/p&gt;</Body>';
        xml += '<IsActive field="IsActive__c" type="field">true</IsActive>';
        xml += '<HasSegments field="HasSegments__c" type="field">true</HasSegments>';
        xml += '<ExtractText field="ExtractText__c" type="field">&lt;p&gt;Hola esto es un texto aburrido&lt;/p&gt;</ExtractText>';
        xml += '<Title field="Title__c" type="field">Title News</Title>';
        xml += '<segments object="SegmentDomain__c" type="relatedList">';
        xml += '<segment type="recordName">Seg2</segment>';
        xml += '</segments>';
        xml += '</new>                                  ';
        xml += '</news>';
        xml += '</component>';
        xml += '</components>';
        xml += '</section>';
        xml += '</sections>';
        xml += '</section>';
        xml += '</sections>';
        xml += '<segments object="SegmentDomain__c" type="relatedList">';
        xml += '<segment type="recordName">Seg1</segment>';
        xml += '</segments>';
        xml += '</menu>';
        xml += '</menus>';

        //MenuUtil.importMenus(xml, program.Id, false);
    }

}