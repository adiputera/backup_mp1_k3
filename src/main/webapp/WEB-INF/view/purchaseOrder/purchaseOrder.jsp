<%@ include file="/WEB-INF/view/masterPage/layout.jsp"%>
<section class="content">
	<h3>Purchase Request</h3>
	<hr style="border-color:black;">
	<div class="row">
		<div class="col-xs-3">
			<div class="form-group">
		       <button type="button" class="btn btn-default pull-right btn-block" id="pilih-tanggal-range">
		         <span>
		           <i class="fa fa-calendar"></i> Pilih Tanggal
		         </span>
		         <i class="fa fa-caret-down"></i>
		       </button>
		    </div>
	    </div>
	    
	    <div class="col-xs-2">
		    <div class="form-group">
		    	<select id="pil-status" class="form-control">
		    		<option value="All">All</option>
		    		<option value="Created">Created</option>
		    		<option value="Approved">Approved</option>
		    		<option value="Rejected">Rejected</option>
		    		<option value="Processed">Processed</option>
		    	</select>
		    </div>
	    </div>
	    
	    <div class="col-xs-3">
		    <div class="form-group">
		    	<input type="text" id="cari-pr" class="form-control" placeholder="Search...">
		    </div>
	    </div>
	    
	    <div class="col-xs-2">
		    <div class="form-group">
		    	
		    </div>
	    </div>
	    <div class="col-xs-2">
		    <div class="form-group">
		    	<input type="button" id="btn-export" class="btn btn-md btn-primary float-right btn-block" value="Export">
		    </div>
	    </div>
	</div>
	<hr>
	<table id="data-po" class="table table-striped table-bordered table-hover">
		<thead class="thead-light">
			<th>Create Date</th>
			<th>Supplier</th>
			<th>PO No.</th>
			<th>Total</th>
			<th>Status</th>
			<th>#</th>
		</thead>
		<tbody id="isi-data-po">
			<c:forEach items="${pos }" var="po">
				<tr>
					<td>
						<script>
							var waktu = '${po.createdOn}';
							var wkt = waktu.split('.');
							var tanggalJam = wkt[0].split(' ');
							var tgl = tanggalJam[0].split('-');
							var tanggal = tgl[2]+'-'+tgl[1]+'-'+tgl[0];
							document.write(tanggal+' '+tanggalJam[1]);
						</script>
					</td>
					<td>${po.supplier.name }</td>
					<td>${po.poNo }</td>
					<td>${po.grandTotal }
					<td>${po.status }</td>
					<td>
						<input type="button" class="btn-edit-po btn btn-default" value="Edit" key-id="${po.id }"> | 
						<a href='${pageContext.request.contextPath}/transaksi/purchase-order/detail/${po.id}' class="btn-view-pr btn btn-info" key-id="${pr.id }">View</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div id="edit-po" class="modal fade" role="dialog">
		<div class="modal-dialog modal-confirm">
			<div class="modal-content">
				<div class="modal-header">
					
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
						<h4 class="modal-title">Edit PO : </h4>
				</div>
				<div class="modal-body">
					<h4>choose Supplier : </h4>
					<div class="form-group">
						<input type="hidden" id="in-id">
						<input type="hidden" id="in-outlet">
						<select id="pil-supplier" class="form-control">
							<c:forEach items = "${sups }" var = "sup">
								<option value = "${sup.id }">${sup.name }</option>
							</c:forEach>
						</select>
					</div>
	                <div class="form-group">
	                	<h4>Notes : </h4>
	                	<textarea class="form-control" rows="5" id="in-notes"></textarea>
	                </div>
	                
	                <h4>Purchase Request</h4>
	                <hr style="border-color:black;">
	                <table id="data-purchase-item" class="table table-striped table-bordered table-hover">
	                	<thead>
	                		<th>Item</th>
	                		<th>In Stock</th>
	                		<th>Qty.</th>
	                		<th>Unit Cost</th>
	                		<th>Sub Total</th>
	                	</thead>
	                	<tbody id = "list-item">
	                	</tbody>
	                	<tfoot>
							<tr style=" border: none; background: none;">
								<td colspan="4"><strong>TOTAL</strong></td>
								<td id="totalbanget"></td>
							</tr>
						</tfoot>
	                </table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-info" data-dismiss="modal"
						id="batal-insert">Batal</button>
					<button type="button" class="btn btn-primary" id="tblsimpan"
						key="key">Simpan</button>
				</div>
			</div>
		</div>
	</div>
	
	
</section>
</body>
<script>
	$(function(){
		$('#pilih-tanggal-range').daterangepicker(
		      {
		        ranges   : {
		          'Hari Ini'       : [moment(), moment()],
		          'Kemarin'   : [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
		          '7 Hari Terakhit' : [moment().subtract(6, 'days'), moment()],
		          'Sebulan Terakhir': [moment().subtract(29, 'days'), moment()],
		          'Bulan ini'  : [moment().startOf('month'), moment().endOf('month')],
		          'Bulan lalu'  : [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
		        },
		        startDate: moment().subtract(29, 'days'),
		        endDate  : moment()
		      },
		      function (start, end) {
		        $('#pilih-tanggal-range').html(start.format('D MMMM, YYYY') + ' - ' + end.format('D MMMM, YYYY'))
		      }
	    );
	    
	    $('#pilih-tanggal').datepicker({
      		autoclose: true,
      		startDate : new Date()
    	});
	    
	    $('#tblsimpan').on('click',function(evt) {
			evt.preventDefault();
			var pod = [];
			
			$('#list-item > tr').each(function(index,data) {
				var detail = {
						"requestQty" : $(this).find('td').eq(2).text(),
						"variant" : {
							"id" : $(this).attr('key-id')
						},
						"subTotal" : $(this).find('td').eq(4).text(),
						"unitCost" : $('#cost'+$(this).attr('key-id')+'').val()
				};
				pod.push(detail);
				console.log(detail);
			});
			
			var purOrd = {
				"id" : $('#in-id').val(),
				"notes" : $('#in-notes').val(),
				"outlet" : {
					"id" : $('#in-outlet').val()
				},
				"detail" : pod,
				"status" : "Created",
				"supplier" : {
					"id" : $('#pil-supplier').val()
				}
			};
			console.log(purOrd);
			//validate = $('#form-emp').parsley();
			//validate.validate();
			//if(validate.isValid()){
				$.ajax({
					type : 'put',
					url : '${pageContext.request.contextPath}/transaksi/purchase-order/update',
					data : JSON.stringify(purOrd),
					contentType : 'application/json',
					success : function() {
						console.log('simpan');
						window.location = '${pageContext.request.contextPath}/transaksi/purchase-order';
					},
					error : function() {
						alert('save failed');
					}
				});
			//}
		}); // end fungsi simpan
		
		$('#data-po').on('click', '.btn-edit-po', function(){
			console.log('edit');
			$('#list-item').empty();
			var id = $(this).attr('key-id');
			$.ajax({
				type : 'GET',
				url : '${pageContext.request.contextPath}/transaksi/purchase-order/get-one/'+id,
				dataType: 'json',
				success : function(data){
					console.log(data);
					$('#in-notes').val(data.notes);
					$('#in-id').val(data.id);
					$('#in-outlet').val(data.outlet.id);
					$('#totalbanget').text(data.grandTotal);
					//$('#pil-supplier').val(data.supplier.id);
					$(data.detail).each(function(key, val){
						$('#list-item').append(
							'<tr key-id="'+val.variant.id+'"><td>'+val.variant.item.name+'-'+val.variant.name+'</td>'
							+'<td id="td'+val.id+'"></td>'
							+'<td>'+val.requestQty+'</td>'
							+'<td><input type="number" min="10000" max="10000000000" id="cost'+val.variant.id+'" placeholder="20000" value="'+val.unitCost+'" class="edit-cost form-control"></td>'
							+'<td id="subtotal'+val.id+'">'+val.subTotal+'</td>'
						);
						$.ajax({
							type : 'GET',
							url : '${pageContext.request.contextPath}/transaksi/purchase-order/get-inventory?idPo='+id+'&idPod='+val.id,
							dataType: 'json',
							success : function(inv){
								$('#td'+val.id).append(inv[0]);
							}
						});
					})
					$('#edit-po').modal('show');
				}, 
				error : function(){
					console.log('gagal');
				}
			});
		});
		
		$('#list-item').on('keyup', '.edit-cost',function(e){
			var cost = parseInt($(this).val());
			var tr = $(this).parent().parent();
			var subLoc = tr.find('td').eq(4);
			var reqQty = parseInt(tr.find('td').eq(2).text());
			var subTotal = cost*reqQty;
			subLoc.text(subTotal);
			var total = 0;
			$('#list-item > tr').each(function(index,data) {
				var subtot = parseInt($(this).find('td').eq(4).text());
				total = total + subtot;
			});
			$('#totalbanget').text(total);
		});
	});
</script>
</html>