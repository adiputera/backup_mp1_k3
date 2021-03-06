<%@ include file="/WEB-INF/view/masterPage/layout.jsp"%>
<section class="content">
<div class="box content">
	<h3>Purchase Request</h3>
	<hr style="border-color:black;">
	<div class="row">
		<div class="col-xs-3">
			<div class="form-group">
		       <button type="button" class="btn btn-default btn-block" id="pilih-tanggal-range">
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
		    		<option value="Submitted">Submitted</option>
		    		<option value="Approved">Approved</option>
		    		<option value="Rejected">Rejected</option>
		    		<option value="PO Created">PO Created</option>
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
		    	<a href="${pageContext.request.contextPath}/generate/pr" id="btn-export" class="btn btn-md btn-primary btn-block">Export</a>
		    </div>
	    </div>
	    <div class="col-xs-2">
		    <div class="form-group">
		    	<input type="button" id="btn-create" class="btn btn-md btn-primary btn-block" value="Create" data-toggle="modal" data-target="#create-pr">
		    </div>
	    </div>
	</div>
	<hr>
	<table id="data-pr" class="table table-striped table-bordered table-hover">
		<thead class="thead-light">
			<th>Create Date</th>
			<th>PR No.</th>
			<th>Note</th>
			<th>Status</th>
			<th>#</th>
		</thead>
		<tbody id="isi-data-pr">
			<c:forEach items="${prs }" var="pr">
				<tr>
					<td>
						<script>
							var waktu = '${pr.createdOn}';
							var wkt = waktu.split('.');
							document.write(wkt[0]);
						</script>
					</td>
					<td>${pr.prNo }</td>
					<td>${pr.notes }</td>
					<td>${pr.status }</td>
					<td>
						<input type="button" class="btn-edit-pr btn btn-default" value="Edit" key-id="${pr.id }" pr-status="${pr.status }"> |
						<a href='${pageContext.request.contextPath}/transaksi/purchase-request/detail/${pr.id}' class="btn-view-pr btn btn-info" key-id="${pr.id }">View</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
	<div id="create-pr" class="modal fade" role="dialog">
		<div class="modal-dialog modal-confirm">
			<div class="modal-content">
				<div class="modal-header">
					<div class="row" id="div-alert" style="display:none;">
						<div class="col-xs-12">
							<div class="alert alert-sukses" role="alert" id="tampilan-alert">
							  <strong>Sukses!</strong> Data Berhasil Disimpan.
							</div>
						</div>
					</div>
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
						<h4 class="modal-title">Create New PR : ${outletLogin.name }</h4>
						<input type="hidden" id = "pil-outlet" value="${outletLogin.id }">
				</div>
				<div class="modal-body">
				<form id="tambah-pr">
					<h4>Tanggal Waktu Item Ready : </h4>
					<div class="row form-group" id="div-tanggal-1">
							<div class="col-xs-12">
								<label class="control-label" for="pilih-tanggal" style="display:none" id="lbl-tanggal"><i class="fa fa-check"></i></label>
	                		</div>
	                </div>
					<div class="input-group date" id="div-tanggal">
	                	<div class="input-group-addon">
	                  		<i class="fa fa-calendar"></i>
	                	</div>
	                	<input type="text" class="datepicker form-control pull-right" id="pilih-tanggal" data-parsley-required="true" required readonly>
	                	<input type="hidden" id="in-id">
	                </div>
	                <div class="form-group" id="div-notes">
	                	<h4>Notes : </h4>
	                	<label class="control-label" for="in-notes" style="display:none" id="lbl-notes"><i class="fa fa-check"></i></label>
	                	<textarea class="form-control" rows="5" id="in-notes" data-parsley-required="true" required></textarea>
	                </div>
	            </form>
	                <h4>Purchase Request</h4>
	                <hr style="border-color:black;">
	                <div class="row">
		                <div class="col-xs-12 form-group" id="div-item">
		                	<label class="control-label" for="data-purchase-item" style="display:none" id="lbl-item"><i class="fa fa-check"></i></label>
			                <table id="data-purchase-item" class="table table-striped table-bordered table-hover" style="display:none;">
			                	<thead>
			                		<th>
			                			Item
			                		</th>
			                		<th>
			                			In Stock
			                		</th>
			                		<th>
			                			Request Qty.
			                		</th>
			                	</thead>
			                	<tbody id = "list-item">
			                	</tbody>
			                </table>
		                </div>
	                </div>
	                <button type="button" class="btn btn-md btn-primary btn-block" id="btn-tambah-item" data-toggle="modal" data-target="#add-item-pr">Add Item</button>
	                
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" 
						id="submit-pr">Submit</button>
					<button type="button" class="btn btn-info" data-dismiss="modal"
						id="batal-insert">Cancel</button>
					<button type="button" class="btn btn-primary" id="tblsimpan"
						key="key">Save</button>
				</div>
			</div>
		</div>
	</div>
	
	<div id="add-item-pr" class="modal fade" role="dialog">
		<div class="modal-dialog modal-confirm">
			<div class="modal-content">
				<div class="modal-header">
					
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title">Add Purchase Item</h4>
				</div>
				<div class="modal-body">
					<input type="text" id="search-item" class="form-control">
					<table id="data-barang" class="table table-striped table-bordered table-hover">
						<thead>
							<th>Item</th>
							<th>In Stock</th>
							<th>Request Qty.</th>
						</thead>
						<tbody id="list-barang">
							
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-info" id="batalinsert">Reset</button>
					<button type="button" class="btn btn-primary" id="tblkonfadd">Save</button>
				</div>
			</div>
		</div>
	</div>
</section>
</body>
<script>
	var itemsss = [];
	$.ajax({
		type : 'get',
		url : '${pageContext.request.contextPath}/transaksi/purchase-request/get-item',
		dataType : 'json',
		success : function(data){
			$.each(data, function(key, val) {
				var namaItem = val.itemVariant.item.name +'-'+ val.itemVariant.name;
				itemsss.push(namaItem);
			});
		}, error : function(){
			
		}
	});
	
	$(function(){
		var awal = '';
		var akhir = '';
		$('#pilih-tanggal-range').daterangepicker(
		      {
		        ranges   : {
		          'Hari Ini'       : [moment(), moment()],
		          'Kemarin'   : [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
		          '7 Hari Terakhir' : [moment().subtract(6, 'days'), moment()],
		          'Sebulan Terakhir': [moment().subtract(29, 'days'), moment()],
		          'Bulan ini'  : [moment().startOf('month'), moment().endOf('month')],
		          'Bulan lalu'  : [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
		        },
		        startDate: moment().subtract(29, 'days'),
		        endDate  : moment(),
		      },
		      function (start, end) {
		        $('#pilih-tanggal-range').html(start.format('D MMMM YYYY') + ' - ' + end.format('D MMMM YYYY'));
		        awal = start.format('YYYY-MM-DD');
		        akhir = end.format('YYYY-MM-DD');
		        if(awal == akhir){
		        	ur = '${pageContext.request.contextPath}/transaksi/purchase-request/search-one-date?date='+awal;
		        }else{
		        	ur = '${pageContext.request.contextPath}/transaksi/purchase-request/search-date?awal='+awal+'&akhir='+akhir;
		        }
		        search();
		      }
	    );
	    
	    $('#pilih-tanggal').datepicker({
      		autoclose: true,
      		startDate : '+1d',
    	});
	    
	    var stat = '';
	    
	    $('#tblsimpan').on('click',function(evt) {
			evt.preventDefault();
			stat = 'Created';
			simpan();
		}); 
	    
	    $('#submit-pr').on('click', function(evt){
	    	evt.preventDefault();
	    	stat = 'Submitted';
			simpan();
	    });
	    
		//fungsi simpan
		function simpan(){
			var jmlBrg = $('#list-item tr').length;
			
			var prd = [];
			$('#list-item > tr').each(function(index,data) {
				var detail = {
						"requestQty" : $(this).find('td').eq(2).text(),
						"variant" : {
							"id" : $(this).attr('key-id')
						}
				};
				prd.push(detail);
			});
			
			var tgl = $('#pilih-tanggal').val().split('/');
			var tanggal = tgl[2]+'-'+tgl[0]+'-'+tgl[1];
			var purReq = {
				"id" : $('#in-id').val(),
				"notes" : $('#in-notes').val(),
				"status" : $('#in-status').val(),
				"outlet" : {
					"id" : $('#pil-outlet').val()
				},
				"detail" : prd,
				"status" : stat,
				"readyTime" : tanggal
			};
			
			if(jmlBrg > 0 && nValid == 1 && tValid == 1){
				validate = $('#tambah-pr').parsley();
				validate.validate();
				if(validate.isValid()){
					$.ajax({
						type : 'post',
						url : '${pageContext.request.contextPath}/transaksi/purchase-request/save',
						data : JSON.stringify(purReq),
						contentType : 'application/json',
						success : function() {
							$('#tampilan-alert').removeClass('alert-gagal').addClass('alert-sukses');
							$('#tampilan-alert').html('<strong>Sukses!</strong> Berhasil Menyimpan ke Database');
							$('#div-alert').fadeIn();
							setTimeout(function() {
								window.location = '${pageContext.request.contextPath}/transaksi/purchase-request';
							}, 2000);
						},
						error : function() {
							$('#tampilan-alert').removeClass('alert-sukses').addClass('alert-gagal');
							$('#tampilan-alert').html('<strong>Error!</strong> Gagal Menyimpan ke Database');
							$('#div-alert').fadeIn();
							setTimeout(function(){
								$('#div-alert').fadeOut();
							}, 4000);
						}
					});
				}
			}
			if(jmlBrg == 0){
				$('#div-item').removeClass('has-success').addClass('has-error');
				$('#lbl-item').html('<i class="fa fa-times-circle-o"></i> Please select item(s)');
				$('#lbl-item').fadeIn();
			}
			if(nValid == 0){
				$('#div-notes').removeClass('has-success').addClass('has-error');
				$('#lbl-notes').html('<i class="fa fa-times-circle-o"></i> Please insert notes');
				$('#lbl-notes').fadeIn();
			}
			if(tValid == 0){
				$('#div-tanggal').removeClass('has-success').addClass('has-error');
				$('#div-tanggal-1').removeClass('has-success').addClass('has-error');
				$('#lbl-tanggal').html('<i class="fa fa-times-circle-o"></i> Please select date');
				$('#lbl-tanggal').fadeIn();
			}
		};
		
		
		var added = [];
		var addedEdit = [];
		var lagiEdit = 0;
		// auto complete
		var itemss = {
				data : itemsss,
		};
		
		$('#search-item').easyAutocomplete(itemss);
		
		$('#btn-tambah-item').on('click', function(){
			var isiBarang = $('#list-item').html();
		});
		
		$(".easy-autocomplete").removeAttr("style");
		
		// fungsi search
	    $('#search-item').on('keyup',function(e){
	    	
			var word = $(this).val();
			if (word=="") {
				$('#list-barang').empty();
			} else {
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/transaksi/purchase-request/search-item?search='+word,
					dataType: 'json',
					success : function(data){
						
						$('#list-barang').empty();
						$.each(data, function(key, val) {
							$('#list-barang').append(
								'<tr id = "tr'+val.id+'"><td>'+ val.itemVariant.item.name +'-'+ val.itemVariant.name +'</td>'
								+'<td id="inStock'+ val.id +'">'+ val.beginning +'</td>'
								+'<td id="td-qty'+ val.id +'"><input type="number" mmin="1" max="1000" id="reqQty'+ val.id +'" value="1" /></td>'
								+'<td><button type="button" id="'+ val.id +'" class="tbl-add-brg btn btn-primary btn-add'+val.id
								+'" key-id="'+val.itemVariant.id+'">Add</button></td></tr>');
						});
					}, 
					error : function(){
						$('#list-barang').empty();
					}
				});
			}
		}); // end fungsi search
		
		$('#list-barang').on('click', '.tbl-add-brg', function(){
			var element = $(this).parent().parent();
			var id = $(this).attr('id');
			var variantId = $(this).attr('key-id');
			var itemVar = element.find('td').eq(0).text();
			var inStock = element.find('td').eq(1).text();
			var reqQty = $('#reqQty'+id).val();
			if(added.indexOf(variantId.toString()) == -1) {
				$('#list-item').append(
					'<tr key-id="'+variantId+'" id="'+variantId+'"><td>'+itemVar+'</td>'
					+'<td>'+inStock+'</td>'
					+'<td>'+reqQty+'</td>'
					+'<td><button type="button" class="btn btn-danger btn-hapus-barang" id="btn-del'+id+'" key-id="'+id+'">&times;</button>'
				);
				added.push(variantId);
				
			}else{
				var target = $('#list-item > #'+variantId+'');
				var oldReq = target.find('td').eq(2).text();
				var newReq = parseInt(oldReq)+parseInt(reqQty);
				target.find('td').eq(2).text(newReq);
			}
			$('#data-purchase-item').trigger('update');
		});
		
		$('#data-purchase-item').on('click', '.btn-hapus-barang', function(){
			var id = $(this).attr('key-id');
			$(this).parent().parent().remove();
			var index = added.indexOf(id.toString());
			if(index > -1){
				added.splice(index, 1);
			}
			$('#data-purchase-item').trigger('update');
		});
		
		var isiBarang = '';
		
		$('#data-pr').on('click', '.btn-edit-pr', function(){
			var isiEdit = '';
			added= [];
			addedEdit = [];
			lagiEdit = 1;
			$('#list-item').empty();
			var id = $(this).attr('key-id');
			$.ajax({
				type : 'GET',
				url : '${pageContext.request.contextPath}/transaksi/purchase-request/get-one/'+id,
				dataType: 'json',
				success : function(data){
					
					$('#in-notes').val(data.notes);
					$('#in-id').val(data.id);
					var tgl = data.readyTime.split('-');
					var tanggal = tgl[1]+'/'+tgl[2]+'/'+tgl[0];
					$('#pilih-tanggal').val(tanggal);
					$(data.detail).each(function(key, val){
						added.push(''+val.variant.id+'');
						addedEdit = added;
						isiEdit = '<tr key-id="'+val.variant.id+'" id="'+val.variant.id+'"><td>'+val.variant.item.name+'-'+val.variant.name+'</td>'
						+'<td id="td'+val.id+'"></td>'
						+'<td>'+val.requestQty+'</td>'
						+'<td><button type="button" class="btn btn-danger btn-hapus-barang" id="btn-del'+id+'" key-id="'+id+'">&times;</button>';
						$('#list-item').append(isiEdit);
						$.ajax({
							type : 'GET',
							url : '${pageContext.request.contextPath}/transaksi/purchase-request/get-inventory?idPr='+id+'&idPrd='+val.id,
							dataType: 'json',
							success : function(inv){
								$('#td'+val.id).append(inv[0]);
							}
						});
					});
					
					if(data.status=='Created'){
						$('#tblsimpan').prop('disabled', false);
						$('#submit-pr').prop('disabled', false);
						$('#pilih-tanggal').prop('disabled', false);
						$('#in-notes').prop('disabled', false);
						$('.btn-hapus-barang').prop('disabled', false);
						$('#btn-tambah-item').prop('disabled', false);
					}else{
						$('#tblsimpan').prop('disabled', true);
						$('#submit-pr').prop('disabled', true);
						$('#pilih-tanggal').prop('disabled', true);
						$('#in-notes').prop('disabled', true);
						$('.btn-hapus-barang').prop('disabled', true);
						$('#btn-tambah-item').prop('disabled', true);
					};
					$('#create-pr').modal('show');
				}, 
				error : function(){
					console.log('gagal');
				}
			});
		});
		
		var ur='';
		
		function search(){
			$.ajax({
				type : 'GET',
				url : ur,
				success : function(data){
					$('#isi-data-pr').empty();
					$(data).each(function(key, val){
						var json_data = '/Date('+val.createdOn+')/';
						var asAMoment = moment(json_data);
						var tanggal = asAMoment.format('DD-MM-YYYY HH:mm:ss');
						
						$('#isi-data-pr').append('<tr><td>'+tanggal+'</td>'
							+'<td>'+val.prNo+'</td>'
							+'<td>'+val.notes+'</td>'
							+'<td>'+val.status+'</td>'
							+'<td><input type="button" class="btn-edit-pr btn btn-default" value="Edit" key-id="'+val.id+'" pr-status="'+val.status+'"> | '
							+'<a href="${pageContext.request.contextPath}/transaksi/purchase-request/detail/'+val.id+'" class="btn-view-pr btn btn-info" key-id="'+val.id+'">View</a></td>');
					})
				},
				error : function(){
					$('#isi-data-pr').empty();
					console.log('gagal');
				}
			});
		}
		
		$('#pil-status').change(function(){
			var status = $(this).val();
			if(status == 'All'){
				ur = '${pageContext.request.contextPath}/transaksi/purchase-request/get-all';
				search();
			}else{
				ur = '${pageContext.request.contextPath}/transaksi/purchase-request/search-status?search='+status;
				search();
			}
		});
		
		$('#cari-pr').on('keyup', function(){
			var word = $(this).val();
			if (word=="") {
				ur = '${pageContext.request.contextPath}/transaksi/purchase-request/get-all';
				search();
			} else {
				ur = '${pageContext.request.contextPath}/transaksi/purchase-request/search?search='+word;
				search();
			}
		});
		
		$('#btn-create').on('click', function(){
			$('#tblsimpan').prop('disabled', false);
			$('#submit-pr').prop('disabled', false);
			$('#pilih-tanggal').prop('disabled', false);
			$('#in-notes').prop('disabled', false);
			$('.btn-hapus-barang').prop('disabled', false);
			$('#btn-tambah-item').prop('disabled', false);
			$('#pilih-tanggal').val('');
			$('#in-notes').val('');
			$('#list-item').empty();
			isiEdit='';
			added = [];
			addedEdit = [];
			lagiEdit = 0;
		});
		
		$('#batalinsert').on('click', function(){
			console.log('clicked');
			$('#list-item').empty();
			added = [];
			if(lagiEdit == 1){
				added = addedEdit;
			}
			$('#list-item').append(isiBarang);
		});
		
		$('#tblkonfadd').on('click', function(){
			$('#add-item-pr').modal('hide');
		});
		
		var tValid = 0;
		
		$('#pilih-tanggal').on('change', function(){
			var tanggal = $(this).val().length;
			if(tanggal > 0){
				$('#div-tanggal').removeClass('has-error').addClass('has-success');
				$('#div-tanggal-1').removeClass('has-error').addClass('has-success');
				$('#lbl-tanggal').html('<i class="fa fa-check"></i> Ok');
				$('#lbl-tanggal').fadeIn();
				tValid = 1;
			}else{
				$('#div-tanggal').removeClass('has-success').addClass('has-error');
				$('#div-tanggal-1').removeClass('has-success').addClass('has-error');
				$('#lbl-tanggal').html('<i class="fa fa-times-circle-o"></i> Please select date');
				$('#lbl-tanggal').fadeIn();
				tValid = 0;
			}
		});
		
		var nValid = 0;
		
		$('#in-notes').on('input', function(){
			var notes = $(this).val().length;
			if(notes > 0){
				$('#div-notes').removeClass('has-error').addClass('has-success');
				$('#lbl-notes').html('<i class="fa fa-check"></i> Ok');
				$('#lbl-notes').fadeIn();
				nValid = 1;
			}else{
				$('#div-notes').removeClass('has-success').addClass('has-error');
				$('#lbl-notes').html('<i class="fa fa-times-circle-o"></i> Please insert notes');
				$('#lbl-notes').fadeIn();
				nValid = 0;
			}
		});
		
		$('#data-purchase-item').on('update', function(){
			var jmlBrg = $('#list-item tr').length;
			if(jmlBrg > 0){
				$('#div-item').removeClass('has-error').addClass('has-success');
				$('#lbl-item').html('<i class="fa fa-check"></i> Ok');
				$('#lbl-item').fadeIn();
				$(this).fadeIn();
			}else{
				$('#div-item').removeClass('has-success').addClass('has-error');
				$('#lbl-item').html('<i class="fa fa-times-circle-o"></i> Please select item(s)');
				$('#lbl-item').fadeIn();
				$(this).fadeOut();
			}
		});
		
		$('#data-pr').DataTable({
			'paging' : true,
			'lengthChange' : false,
			'searching' : false,
			'ordering' : true,
			'info' : true,
			'autoWidth' : false
		})
	});
</script>
</html>