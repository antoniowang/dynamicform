<p class="default-buttons" id="default-buttons-1" style="text-align:center">
    <s:set value="0" var="indexWizard"/>
    <s:iterator value="wizardAction" var="var" status="index">
        <s:if test="%{#request['struts.request_uri'].contains(#var[0])}">
            <s:set value="#index.index" var="indexWizard"/>
        </s:if>
    </s:iterator>
    <s:if test="%{#indexWizard>0}">
        <s:a href="%{wizardAction[#indexWizard-1][0]+'.action?activeWizard='+wizardAction[#indexWizard-1][0] +'&id='+id}"
             cssClass="btn btn-info">
            前一步</s:a>
    </s:if>
    <button id="studyActionSave" class="btn btn-info" type="submit" style="margin-left:80px;margin-right:80px">保存</button>
    <s:if test="%{#indexWizard<wizardAction.length-1}">
        <s:a href="%{wizardAction[#indexWizard+1][0]+'.action?activeWizard='+wizardAction[#indexWizard+1][0] +'&id='+id}"
             cssClass="btn btn-info">
            下一步</s:a>
    </s:if>
</p>

