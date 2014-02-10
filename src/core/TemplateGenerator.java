package core;

import core.exception.XmlFileNotFoundException;
import dynamicschema.Component;
import dynamicschema.DynamicType;
import dynamicschema.FieldSet;
import dynamicschema.Form;

import javax.xml.bind.JAXBException;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wangronghua on 14-1-27.
 */
public class TemplateGenerator {

  public boolean genTemplate(String xmlFilePath, String templateId) {
    File template = new File(Constants.TEMPLATE_PATH_TEMP + "/" + templateId);
    try {
      Writer templateWriter = new FileWriter(template);
      XmlReader reader = new XmlReader(xmlFilePath);
      Form form = reader.readForm();
      templateWriter.write(this.genTemplate(form));
    } catch (XmlFileNotFoundException e) {
      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
      //todo exception
    } catch (JAXBException e) {
      e.printStackTrace();
    }
    return true;
  }

  String genTemplate(Form form) {
    List<FieldSet> fieldSets = form.getFieldset();
    Map param = new HashMap();
    param.put("form", form);
    param.put("innerHTML", genTemplate(fieldSets.toArray(new FieldSet[0])));
    return TemplateHelper.getTemplate("form", param);
  }

  String genTemplate(FieldSet[] fieldSets) {
    StringBuilder result = new StringBuilder();
    for(FieldSet fieldSet: fieldSets) {
      List<DynamicType> dynamicTypes = fieldSet.getElement();
      String dtString = genTemplate(dynamicTypes.toArray(new DynamicType[0]));
      Map paraMap = new HashMap();
      paraMap.put("fieldset", fieldSet);
      paraMap.put("innerHTML", dtString);
      result.append(TemplateHelper.getTemplate("fieldset", paraMap));
    }
    return result.toString();
  }

  String genTemplate(DynamicType[] dynamicTypes) {
    StringBuilder result = new StringBuilder();
    for(DynamicType dynamicType: dynamicTypes) {
      StringBuilder type = new StringBuilder("get").append(dynamicType.getType());
      type.setCharAt(3, Character.toUpperCase(type.charAt(3)));
      try {
        Method med = DynamicType.class.getDeclaredMethod(type.toString());
        Component component = (Component)med.invoke(dynamicType);
        result.append(TemplateHelper.getTemplate(dynamicType.getType().toLowerCase(), component)) ;
      } catch (NoSuchMethodException e) {
        //todo LOG.error();
      } catch (InvocationTargetException e) {
        e.printStackTrace();
      } catch (IllegalAccessException e) {
        e.printStackTrace();
      }

    }
    return result.toString();
  }
}
