/*  Render HTML */
public class FieloCMSPLT_HTML implements FieloCMS.ViewSubComponentInterface {
	public ApexPages.Component getSubComponent(FieloCMS.Field field, SObject record){        
    Component.FieloCMSPLT_HTML html = new Component.FieloCMSPLT_HTML();
    if (record != null) {
      html.record = record;
    } else {
      html.expressions.record = '{!record}';
    }
    html.field = field;
    return html;
  }
}