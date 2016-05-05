/**
 * @brief    Extension generica de Error utilizada para las excepciones propias de Fielo
 */
global class FieloCustomException extends Exception {

	public String field;

	public String getField(){
		return field;
	}

}