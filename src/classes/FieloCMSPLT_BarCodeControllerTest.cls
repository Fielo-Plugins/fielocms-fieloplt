@isTest
private class FieloCMSPLT_BarCodeControllerTest{
    @isTest
    static void itShould_1(){

    	FieloCMSPLT_BarCodeController controller = new FieloCMSPLT_BarCodeController();
    	controller.cCode = '123456';
    	controller.getFullNumber();
    	
    	controller.withCheckSum = true;
    	controller.getFullNumber();

		controller.getBodyElementsWidth();
    }
}