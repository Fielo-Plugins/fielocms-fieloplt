/**
* @author Diego Amarante
* @date 11/08/2011
* @description Class used to perform a bar code
*/
global with sharing class FieloCMSPLT_BarCodeCtrl {
	//Variables
    global String cCode {get; set;}        // codebar number
    global Boolean withCheckSum {get; set;} // Boolean to agregate the verificator digit at the end of the barcode in relation with the UPC rutine (http://en.wikipedia.org/wiki/Universal_Product_Code)

    private Integer longValue = 0;

    /**
	* @author Diego Amarante
	* @date 11/08/2011
	* @description Constructor
	*/
    global FieloCMSPLT_BarCodeCtrl(){
        withCheckSum = false;
    }

    global static List<String> barcode = new List<String> {
        '0000111100', '0100101001', '0001101001', '0101101000', '0000111001',
        '0100111000', '0001111000', '0000101101', '0100101100', '0001101100',
        '1000010110', '1100000011', '1001000011', '1101000010', '1000010011',
        '1100010010', '1001010010', '1000000111', '1100000110', '1001000110',
        '0010010110', '0110000011', '0011000011', '0111000010', '0010010011',
        '0110010010', '0011010010', '0010000111', '0110000110', '0011000110',
        '1010010100', '1110000001', '1011000001', '1111000000', '1010010001',
        '1110010000', '1011010000', '1010000101', '1110000100', '1011000100',
        '0000110110', '0100100011', '0001100011', '0101100010', '0000110011',
        '0100110010', '0001110010', '0000100111', '0100100110', '0001100110',
        '1000110100', '1100100001', '1001100001', '1101100000', '1000110001',
        '1100110000', '1001110000', '1000100101', '1100100100', '1001100100',
        '0010110100', '0110100001', '0011100001', '0111100000', '0010110001',
        '0110110000', '0011110000', '0010100101', '0110100100', '0011100100',
        '0000011110', '0100001011', '0001001011', '0101001010', '0000011011',
        '0100011010', '0001011010', '0000001111', '0100001110', '0001001110',
        '1000011100', '1100001001', '1001001001', '1101001000', '1000011001',
        '1100011000', '1001011000', '1000001101', '1100001100', '1001001100',
        '0010011100', '0110001001', '0011001001', '0111001000', '0010011001',
        '0110011000', '0011011000', '0010001101', '0110001100', '0011001100'
    };

    /**
    * @author Diego Amarante
    * @date 11/08/2011
    * @description Method to get the complete number code
    * @return String
    */
    global String getFullNumber(){
        String code = '';
        Integer sum = 0;
        for(Integer i = 0 ; i < cCode.length() ; i++){
            String stringNumber = cCode.substring(i,i+1);
            if(stringNumber >= '0' && stringNumber <= '9'){
                code += stringNumber;
                if(Math.Mod(i, 2) == 0){
                    sum += Integer.ValueOf(stringNumber);
                }else{
                    sum += Integer.ValueOf(stringNumber) * 3;
                }
            }
        }
        longValue = code.length();
        if(withCheckSum){
            code += String.valueOf(Math.Mod(10 - Math.Mod(sum, 10),10));
            longValue++;
        }
        if(Math.mod(longValue,2) != 0){
            code = '0' + code;
            longValue++;
        }
        return code;
    }

    /**
    * @author Diego Amarante
    * @date 11/08/2011
    * @description Method to get the Body Elements Width
    * @return List<Integer>
    */
    global List<Integer> getBodyElementsWidth(){
        List<Integer> result = new List<Integer>();
        if( !String.isEmpty(cCode)){
            String code = getFullNumber();
            for(Integer indexValue = 0 ; indexValue < longValue ; indexValue += 2){
                String f = barcode[Integer.ValueOf( code.substring(indexValue,indexValue+2))];
                for(Integer i=0; i < 10; i += 2){
                    Integer f1 = (f.substring(i,i+1) == '0') ? 0 : 1;
                    Integer f2 = (f.substring(i+1,i+2) == '0') ? 0 : 1;
                    result.add(f1);
                    result.add(f2);
                }
            }
        }
        return result;
    }
}