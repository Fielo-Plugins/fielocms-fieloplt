@isTest
private class BarCodeControllerTest{
    @isTest
    static void itShould_1(){

    	BarCodeController controller = new BarCodeController();
    	controller.cCode = '123456';
    	controller.getFullNumber();
    	
    	controller.withCheckSum = true;
    	controller.getFullNumber();

		controller.getBodyElementsWidth();
    }
}