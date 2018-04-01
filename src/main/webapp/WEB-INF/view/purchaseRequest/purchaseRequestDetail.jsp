<%@ include file="/WEB-INF/view/masterPage/layout.jsp"%>
<section class="content">
<div class="row">
	<div class="col-xs-9">
		<h3>PURCHASE REQUEST DETAIL</h3>
		<hr style="border-color: black; border-top: 1px dashed;">
	</div>
	<div class="col-xs-3">
		<script>
			if('${pr.status}' == 'Created'){
				document.write('<select id="action-pr" class="btn-primary form-control" key-id="${pr.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="approve">Approve</option>'
						+'<option value="reject">Reject</option>'
						+'<option value="print">Print</option>'
						+'<option value="create-po" disabled>Create PO</option>');
			}else if('${pr.status}' == 'Rejected'){
				document.write('<select id="action-pr" class="btn-primary form-control" key-id="${pr.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="approve" disabled>Approve</option>'
						+'<option value="reject" disabled>Reject</option>'
						+'<option value="print">Print</option>'
						+'<option value="create-po" disabled>Create PO</option>');
			}else if('${pr.status}' == 'PO Created'){
				document.write('<select id="action-pr" class="btn-primary form-control" key-id="${pr.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="approve" disabled>Approve</option>'
						+'<option value="reject" disabled>Reject</option>'
						+'<option value="print">Print</option>'
						+'<option value="create-po" disabled>Create PO</option>');
			}else if('${pr.status}' == 'Approved'){
				document.write('<select id="action-pr" class="btn-primary form-control" key-id="${pr.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="approve" disabled>Approve</option>'
						+'<option value="reject" disabled>Reject</option>'
						+'<option value="print">Print</option>'
						+'<option value="create-po">Create PO</option>');
			}
		</script>
			
		</select>
	</div>
</div>
<div class="row">
<div class="col-xs-12">
<table class="table table-hover table-borderless">
	<tr>
		<td><b>PR Number</b> : ${pr.prNo }</td>
	</tr>
	<tr>
		<td><b>Created By</b> : ${pr.createdBy }</td>
	</tr>
	<tr>
		<td><b>Target Waktu Item Ready</b> : 
			<script>
				var tanggal = '${pr.readyTime}';
				var tgl = tanggal.split('-');
				document.write(tgl[2]+'-'+tgl[1]+'-'+tgl[0]);
			</script>
		</td>
	</tr>
	<tr>
		<td><b>PR Status</b> : ${pr.status }</td>
	</tr>
</table>
</div>
</div>
<div class="form-group">
	<label for="input-note">Notes</label>
	<textarea class="form-control" id="input-note" rows="5" style="resize:none;" readonly>${pr.notes }</textarea>
</div>
<h5>
	<b>Status History</b>
</h5>
<hr style="border-color: black; border-top: 1px dashed;">
<div class="row">
	<div class="col-xs-8">
		<table id="data-history" class="table table-striped table-hover table-borderless">
			<c:forEach items="${pr.history }" var="his">
				<tr>
					<td>On
					
						<script>
							var waktu = '${his.createdOn}';
							var wkt = waktu.split('.');
							document.write(wkt[0]);
						</script>
					
					-
					${pr.prNo }
					is
					${his.status }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>

<h5>
	<b>Purchase Items</b>
</h5>
<hr style="border-color: black; border-top: 1px dashed;">
<table id="data-purchase-item"
	class="table table-striped table-bordered table-hover">
	<thead>
		<th>Item</th>
		<th>In Stock</th>
		<th>Request Qty.</th>
	</thead>
	<tbody id="list-item">
		<c:forEach items="${pr.detail }" var ="prd">
			<tr>
				<td>${prd.variant.item.name }-${prd.variant.name }</td>
				<td>null</td>
				<td>${prd.requestQty }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div class="row">
	<div class="col-xs-9"></div>
	<div class="col-xs-3"><a href="${pageContext.request.contextPath}/transaksi/purchase-request" class="btn btn-primary btn-block">Done</a></div>
</div>
</section>
</body>
<script>
	$(function(){
		
		$('#action-pr').change(function(){
			var action = $(this).val();
			var id = $(this).attr('key-id');
			if(action == 'print'){
				window.print();
			}else{
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/transaksi/purchase-request/'+action+'/'+id,
					success : function(){
						console.log('sukses');
						window.location = '${pageContext.request.contextPath}/transaksi/purchase-request/detail/'+id;
					},
					error : function(){
						console.log('gagal');
					}
				});
			}
		});
	})
</script>
</html>