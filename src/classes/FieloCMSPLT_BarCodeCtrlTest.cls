@isTest
private class FieloCMSPLT_BarCodeCtrlTest{
    @isTest
    static void itShould_1(){

    	FieloCMSPLT_BarCodeCtrl controller = new FieloCMSPLT_BarCodeCtrl();
    	controller.cCode = '123456';
    	controller.getFullNumber();
    	
    	controller.withCheckSum = true;
    	controller.getFullNumber();

		controller.getBodyElementsWidth();
    }
}