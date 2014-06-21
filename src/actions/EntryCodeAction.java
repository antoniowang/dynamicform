package actions;

import bl.beans.EntryBean;
import bl.beans.EntryCodeBean;
import bl.common.BusinessResult;
import bl.mongobus.EntryCodeBusiness;
import org.apache.commons.lang.StringUtils;
import vo.table.TableHeaderVo;
import vo.table.TableInitVo;
import vo.table.TableQueryVo;

/**
 * Created by wangronghua on 14-6-21.
 */
public class EntryCodeAction extends BaseTableAction<EntryCodeBusiness> {

  private String entryId;
  private EntryCodeBean entryCode;

  @Override
  public String getActionPrex() {
    return getRequest().getContextPath() + "/entryCode";
  }

  @Override
  public TableInitVo getTableInit() {
    TableInitVo init = new TableInitVo();
    init.getAoColumns().add(new TableHeaderVo("name", "名称").enableSearch());
    init.getAoColumns().add(new TableHeaderVo("abbreviation", "缩写").enableSearch());
    init.getAoColumns().add(new TableHeaderVo("key", "标识"));
    init.getAoColumns().add(new TableHeaderVo("value", "值"));
    return init;
  }

  @Override
  public String save() throws Exception {
    BusinessResult result = null;
    if (StringUtils.isEmpty(entryCode.getId())) {
      result = getBusiness().createLeaf(entryCode);
    } else {
      result = getBusiness().updateLeaf(entryCode, entryCode);
    }
    if (result != null && result.getErrors().size() > 0) {
      for (Object error : result.getErrors()) {
        addActionError(error.toString());
      }
      return INPUT;
    }
    if (result != null && result.getMessages().size() > 0) {
      for (Object message : result.getMessages()) {
        addActionMessage(message.toString());
      }
      return SUCCESS;
    }
    return SUCCESS;
  }

  public String edit() {
    entryCode = (EntryCodeBean) getBusiness().getLeaf(getId()).getResponseData();
    return SUCCESS;
  }

  @Override
  public String delete() throws Exception {
    if (getIds() != null) {
      for (String id : getIds()) {
        getBusiness().deleteLeaf(id);
      }
    }
    return SUCCESS;
  }

  @Override
  public String add() {
    entryCode = new EntryCodeBean();
    entryCode.setEntryId(this.entryId);
    return SUCCESS;
  }
  @Override
  public String getTableTitle() {
    return "<ul class=\"breadcrumb\"><li>系统模块</li><li class=\"active\">编码</li></ul>";
  }
  @Override
  public TableQueryVo getModel() {
    TableQueryVo model = super.getModel();
    model.getFilter().put("entryId", this.entryId + "");
    return model;
  }

  @Override
  public String getAddButtonParameter(){
    return "entryId="+this.entryId;
  }

  public EntryCodeBean getEntryCode() {
    return entryCode;
  }

  public void setEntryCode(EntryCodeBean entryCode) {
    this.entryCode = entryCode;
  }

  public String getEntryId() {
    return entryId;
  }

  public void setEntryId(String entryId) {
    this.entryId = entryId;
  }
}
