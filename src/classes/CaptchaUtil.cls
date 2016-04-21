/**
 * @brief      API para la seccion de acciones de Captcha
 * @details    La API contiene metodos estaticos para realizar acciones relacionadas con la validacion de captchas
 */
global class CaptchaUtil {

    public static Boolean verify(Map<String,Object> parameters, String secretKey){
        return verify((String)parameters.get('response'), secretKey);
    }

    /**
     * @brief       Metodo que verifica para si un captcha es valido o no
     * @details     Realiza una validacion con la API de google (https://www.google.com/recaptcha/api/siteverify) y verifica si el valor ingresado por el usuario es verdadero
     * @version     10.0     
     * @param       response        hash devuelto por el componente de captcha del lado del cliente
     * @param       secretKey       Secret Key de la aplicacion generada por captcha     
     * @returns     Si el valor del captcha es correcto o no
     * @retval      Boolean   
     *                      <ul>
     *                         <li> true = La verificacion es correcta
     *                         <li> false = La verificacion es falsa
     *                      </ul>
     * @warning     La API invoca una API call por medio de una llamada HTTP     
     * @code{.java}     
     *          String response;
     *          String secretKey;     
     *          Boolean captchaVerify = FieloEE.CaptchaUtil.verify(response,secretKey);
     * @endcode
     */
	global static Boolean verify(String response, String secretKey){
        String baseUrl = 'https://www.google.com/recaptcha/api/siteverify';
        String remoteIp = getRemoteHost();
        HttpResponse httpResponse = makeRequest(baseUrl,
           'secret=' + secretKey +
           '&remoteip=' + remoteIp +
           '&response=' + response);
        if(httpResponse != null){  // is null when test methods run
            String responseBody = httpResponse.getBody();
            return (responseBody.contains('true'));
        }else{
            return false;
        }
    }

    private static HttpResponse makeRequest(String url, String body){
        HttpRequest req = new HttpRequest();
        HttpResponse response = null;
        req.setEndpoint(url);
        req.setMethod('POST');
        req.setBody (body);
        try{
          Http http = new Http();
          response = http.send(req);
        }catch(System.Exception e){
            throw new FieloCustomException(e.getMessage());
        }
        return response;
    }

    private static String getRemoteHost(){
        if (ApexPages.currentPage() != null){
            Map<String,String> hdrs = ApexPages.currentPage().getHeaders();
            if(hdrs.containsKey('x-original-remote-addr')){
                return hdrs.get('x-original-remote-addr');
            }else if(hdrs.containsKey('X-Salesforce-SIP')){
                return hdrs.get('X-Salesforce-SIP');
            }
        }
        return '127.0.0.1';
    }

}