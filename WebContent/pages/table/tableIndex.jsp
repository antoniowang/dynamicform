<!DOCTYPE html>
<html lang="en">
<%@ include file="../commonHeader.jsp"%>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Mosaddek">
    <meta name="keyword" content="FlatLab, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
    <link rel="shortcut icon" href="img/favicon.png">

    <title>Data Table</title>

    <!-- Bootstrap core CSS -->
    <link href="<%=request.getContextPath()%>/jslib/flatlab/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/jslib/flatlab/css/bootstrap-reset.css" rel="stylesheet">
    <!--external css-->
    <link href="<%=request.getContextPath()%>/jslib/flatlab/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />

    <link href="<%=request.getContextPath()%>/jslib/flatlab/assets/advanced-datatable/media/css/demo_page.css" rel="stylesheet" />
    <link href="<%=request.getContextPath()%>/jslib/flatlab/assets/advanced-datatable/media/css/demo_table.css" rel="stylesheet" />
    <link href="<%=request.getContextPath()%>/jslib/flatlab/assets/data-tables/DT_bootstrap.css" rel="stylesheet" />
    <link href="<%=request.getContextPath()%>/jslib/flatlab/assets/advanced-datatable/extras/TableTools/media/css/TableTools.css" rel="stylesheet" />
    
    


    <!-- Custom styles for this template -->
    <link href="<%=request.getContextPath()%>/jslib/flatlab/css/style.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/jslib/flatlab/css/style-responsive.css" rel="stylesheet" />
   
    <link href="<%=request.getContextPath()%>/css/datatable.css" rel="stylesheet" />
    
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 tooltipss and media queries -->
    <!--[if lt IE 9]>
      <script src="<%=request.getContextPath()%>/jslib/flatlab/js/html5shiv.js"></script>
      <script src="<%=request.getContextPath()%>/jslib/flatlab/js/respond.min.js"></script>
    <![endif]-->
  </head>
  
<body>
  
       <!-- page start-->
       <section class="panel">
           <header class="panel-heading" style="text-align: center;">${tableTitle}</header>
           <div class="panel-body">
                 <div class="adv-table">
                     <table  id="${tableId}" cellpadding="0" cellspacing="0" border="0" class="display table table-bordered">
                       <thead>
                       </thead>
                      <tbody>
                          <tr><td colspan="4" class="dataTables_empty">Loading data from server</td></tr>
                      </tbody>
                          
                     </table>
                </div>
          </div>
     </section>
     <!-- page end-->
           

    <!-- js placed at the end of the document so the pages load faster -->
    <!--<script src="<%=request.getContextPath()%>/jslib/flatlab/js/jquery.js"></script>-->
    <script src="<%=request.getContextPath()%>/jslib/flatlab/assets/advanced-datatable/media/js/jquery.js" type="text/javascript" language="javascript" ></script>
    <script src="<%=request.getContextPath()%>/jslib/flatlab/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/jslib/flatlab/js/jquery.dcjqaccordion.2.7.js" class="include" type="text/javascript" ></script>
    <script src="<%=request.getContextPath()%>/jslib/flatlab/js/jquery.scrollTo.min.js"></script>
    <script src="<%=request.getContextPath()%>/jslib/flatlab/js/jquery.nicescroll.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/jslib/flatlab/js/respond.min.js" ></script>
    <script src="<%=request.getContextPath()%>/jslib/flatlab/assets/advanced-datatable/media/js/jquery.dataTables.js" type="text/javascript" language="javascript" ></script>
    <script src="<%=request.getContextPath()%>/jslib/flatlab/assets/data-tables/DT_bootstrap.js" type="text/javascript" ></script>
    <!--common script for all pages-->
    <script src="<%=request.getContextPath()%>/jslib/flatlab/js/common-scripts.js"></script>

<script src="<%=request.getContextPath()%>/jslib/flatlab/assets/advanced-datatable/extras/TableTools/media/js/ZeroClipboard.js" type="text/javascript" charset="utf-8" ></script>
<script src="<%=request.getContextPath()%>/jslib/flatlab/assets/advanced-datatable/extras/TableTools/media/js/TableTools.js" type="text/javascript" charset="utf-8" ></script>




<script type="text/javascript">
     var cellFormatter = {};
     var actions = [
              {
                  "title":"Add",
                  "multiSelect":true,
                  "disabled": false,
                  "action": function (thisObj){
                      alert("Add for Table "+$(thisObj).attr("for")); 
                  }
              },{
                  "title":"Edit",
                  "multiSelect":false,
                  "action": function (thisObj){
                      alert("Edit for Table "+$(thisObj).attr("for")); 
                  }
              },{
                  "title":"Delete",
                  "multiSelect":true,
                  "action": function (thisObj){
                      alert("Delete for Table "+$(thisObj).attr("for")); 
                  }
              }
      ];
      /* Formating function for row details */
      function fnFormatDetails ( oTable, nTr ){
          var aData = oTable.fnGetData( nTr );
          var aoColumns = oTable.fnSettings().aoColumns;
          var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
          for(var i=0;i<aoColumns.length;i++){
              if(aoColumns[i].bVisible == false){
                  sOut += '<tr><td>'+ aoColumns[i].sTitle+':</td><td>'+aData[aoColumns[i].mData]+'</td></tr>';
              }
          }
          sOut += '</table>';
          return sOut;
      }
 
 $(document).ready(function() {
     var tableUrl = "${actionPrex}/initTable.action";
     var param = {};
     $.getJSON( tableUrl, param, function (initParam) { 
         for(var i=0;i<initParam.aoColumns.length ; i++){
             if(typeof cellFormatter[initParam.aoColumns[i].mData] == "function"){
                 initParam.aoColumns[i].mRender = cellFormatter[initParam.aoColumns[i].mData];
             }
         }
	     /*
	      * Initialse DataTables, with no sorting on the 'details' column
	      */
	     var oTable = $('#${tableId}').dataTable( {
	         "bProcessing": initParam.bProcessing,
	 		 "bServerSide": initParam.bServerSide,
	 		 "iDisplayLength":initParam.iDisplayLength,
	 		 "aLengthMenu": initParam.aLengthMenu,
	 		 "aoColumns": initParam.aoColumns,
	 		 "sAjaxSource": "${actionPrex}/queryTable.action",
	 		 "bFilter":true,
	 		  
		     "fnDrawCallback": function ( oSettings ) {
		            if(initParam.hasDetails > 0){
		                if($('#${tableId} thead tr th:first[arias="showDetails"]').length == 0){
		                    $('#${tableId} thead tr').each( function () {
		                          var thObj =document.createElement( 'th' );
		                          thObj.setAttribute("arias","showDetails");
			                      this.insertBefore(thObj , this.childNodes[0] );
			                 } );
		                }
		                var nCloneTd = document.createElement( 'td' );
		                nCloneTd.innerHTML = '<img src="<%=request.getContextPath()%>/jslib/flatlab/assets/advanced-datatable/examples/examples_support/details_open.png">';
		                nCloneTd.className = "center";
			            $('#${tableId} tbody tr').each( function (i) {
			                this.insertBefore(  nCloneTd.cloneNode( true ) , this.childNodes[0] );
			            } );
			            $('#${tableId} tbody td img').live('click', function () {
			                var nTr = $(this).parents('tr')[0];
			                if ( oTable.fnIsOpen(nTr) ){
			                    // This row is already open - close it 
			                     $(this).attr("src" , "<%=request.getContextPath()%>/jslib/flatlab/assets/advanced-datatable/examples/examples_support/details_open.png");
			                     oTable.fnClose( nTr );
			                }else{
			                   //   Open this row 
			                     $(this).attr("src" , "<%=request.getContextPath()%>/jslib/flatlab/assets/advanced-datatable/examples/examples_support/details_close.png");
			                     oTable.fnOpen( nTr, fnFormatDetails(oTable, nTr), 'details' );
			                     $('td.details',$(nTr).next()).attr("colspan",nTr.childNodes.length);
			                 }
			            } );
		            }
		            $("#${tableId}_filter").empty();
		            if(actions.length > 0){
		                for(var i=actions.length-1;i >=0 ; i--){
		                    var aObj = document.createElement( 'button' );
		                    aObj.setAttribute("onclick","actions["+i+"].action(this)");
		                    aObj.setAttribute("for","${tableId}");
		                    aObj.setAttribute("style","float:right;");
		                    if(actions[i].disabled != false){
		                        aObj.setAttribute("disabled","disabled");
		                    }
		                    aObj.setAttribute("multiSelect",actions[i].multiSelect);
		                    aObj.innerHTML = actions[i].title;
		                    aObj.className = "DTTT_button";
		                    $("#${tableId}_filter").append(aObj);
		                }
		            }
		            
		            /* Add/remove class to a row when clicked on */
		            $('#${tableId} tbody tr').live('click', function() {
		                $(this).toggleClass('row_selected');
		                var selectRows = oTable.$('tr.row_selected');
		                $("#${tableId}_filter button").attr("disabled","disabled");
		                if(selectRows.length == 1){
		                    $("#${tableId}_filter button").removeAttr("disabled");
		                }else if(selectRows.length > 1){
		                    $("#${tableId}_filter button[multiSelect='true']").removeAttr("disabled");
		                }
		            } );
		     }, 
	         "fnServerData": function ( sSource, aoData, fnCallback, oSettings ) {
	             /* //======= method one===========
	             // Add some extra data to the sender 
	 			aoData.push( { "name": "more_data", "value": "my_value" } );
	 			$.getJSON( sSource, aoData, function (json) { 
	 				// Do whatever additional processing you want on the callback, then tell DataTables
	 				fnCallback(json)
	 			} );
	 			 //======= method one END=========== */
	 			     
	 			//========method two==================   
	 			 var mDataObj = {};
	 			 var sortObj = {};
	 			 var iMax = 0;
	 			for(var n=0;n<aoData.length;n++){
	 			    if(aoData[n].name == "iColumns"){
	 			       iMax = aoData[n].value;
	 			    }
	 			    if(aoData[n].name == "mDataProp_0"){
	 			      for(var i = 0; i < iMax;i++){
	 			         mDataObj[aoData[n].name] = aoData[n].value;
	 			         n++;
	 			      }
	 			    }
	 			    if(aoData[n].name == "iSortCol_0"){
	 			      for(var i = 0; i < iMax;i++){
	 			          if(aoData[n].name == "iSortCol_"+i){
	 			               sortObj[mDataObj["mDataProp_"+ aoData[n].value]] = aoData[++n].value;
	 			               n++;
	 			          }else{
	 			              break;
	 			          }
	 			      }
	 			  }
	 			}
	 			for(var p in sortObj){
	 			    aoData.push( { "name": "sort['"+p+"']", "value": sortObj[p] } );
	 			}
	 			$('#${tableId} thead tr th input[type="text"]').each( function (i) {
	 			  aoData.push( { "name": "filter['"+this.name+"']", "value": this.value } );
	 			});
	 			$('#${tableId} thead tr th select[name]').each( function (i) {
	 			  aoData.push( { "name": "filter['"+this.name+"']", "value": $(this).val() } );
		 		});
	 			 oSettings.jqXHR = $.ajax( {
	                 "dataType": 'json',
	                 "type": "POST",
	                 "url": sSource,
	                 "data": aoData,
	                 "success": function(result,status,response){
	                    // Do whatever additional processing you want on the callback, then tell DataTables
	                     fnCallback(result);
	                  }
	               } );
	 			//========method two END==================   
	          }
	        });
 	} );
 } );
  </script>
  <% if(request.getAttribute("customJs")!= null && request.getAttribute("customJs").toString().length() > 0 ){%>
     <script src="${customJs}" type="text/javascript"></script> 
  <%} %>
  </body>

</html>