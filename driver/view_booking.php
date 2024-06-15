<?php
require_once('./../config.php');
// if(isset($_GET['id']) && $_GET['id'] > 0){
//     // $qry = $conn->query("SELECT booking_list.*, client_list.* FROM booking_list JOIN client_list ON booking_list.client_id = client_list.id WHERE booking_list.id = '{$_GET['id']}'");
//     $qry = $conn->query("SELECT * from `booking_list` where id = '{$_GET['id']}' ");
//     if($qry->num_rows > 0){
//         foreach($qry->fetch_assoc() as $k => $v){
//             $$k=$v;
//         }
//         $qry2 = $conn->query("SELECT c.*, cc.name as category from `cab_list` c inner join category_list cc on c.category_id = cc.id where c.id = '{$cab_id}' ");
//         if($qry2->num_rows > 0){
//             foreach($qry2->fetch_assoc() as $k => $v){
//                 if(!isset($$k))
//                 $$k=$v;
//             }
//         }
//     }
// }
$qry = $conn->query("SELECT 
                        booking_list.*, 
                        client_list.firstname, 
                        client_list.middlename, 
                        client_list.lastname, 
                        client_list.contact
                    FROM booking_list 
                    JOIN client_list ON booking_list.client_id = client_list.id
                    WHERE booking_list.id = '{$_GET['id']}'");
if($qry->num_rows > 0){
    $row = $qry->fetch_assoc();
    foreach($row as $k => $v){
        $$k = $v;
    }

    $qry2 = $conn->query("SELECT 
                            c.*, 
                            cc.name as category 
                        FROM cab_list c
                        INNER JOIN category_list cc ON c.category_id = cc.id
                        WHERE c.id = '{$cab_id}'");
    if($qry2->num_rows > 0){
        $row2 = $qry2->fetch_assoc();
        foreach($row2 as $k => $v){
            if(!isset($$k))
                $$k = $v;
        }
    }
}
?>
<style>
    #uni_modal .modal-footer{
        display:none
    }
</style>
<div class="container-fluid">

    <div class="row">
        <div class="col-md-6">
            <fieldset class="bor">
                <legend class="h4 text-muted">Chi tiết xe</legend>
                <dl>
                    <dt class="">Tên xe</dt>
                    <dd class="border-bottom pb-2"><?= isset($body_no) ? $body_no : "" ?></dd>
                    <dt class="">Loại xe</dt>
                    <dd class="border-bottom pb-2"><?= isset($category) ? $category : "" ?></dd>
                    <dt class="">Model xe</dt>
                    <dd class="border-bottom pb-2"><?= isset($cab_model) ? $cab_model : "" ?></dd>
                    <dt class="">Tài xế</dt>
                    <dd class="border-bottom pb-2"><?= isset($cab_driver) ? $cab_driver : "" ?></dd>
                    <dt class="">Số điện thoại</dt>
                    <dd class="border-bottom pb-2"><?= isset($driver_contact) ? $driver_contact : "" ?></dd>
                    <dt class="">Địa chỉ</dt>
                    <dd class="border-bottom pb-2"><?= isset($driver_address) ? $driver_address : "" ?></dd>
                </dl>
            </fieldset>
            <!-- <div class="clear-fix my-2"></div> -->
            
        </div>

        <div class="col-md-6">
            <fieldset class="bor">
                <legend class="h4 text-muted">Chi tiết đặt xe</legend>
                <dl>
                    <dt class="">Mã tham chiếu</dt>
                    <dd class="border-bottom pb-2"><?= isset($ref_code) ? $ref_code : "" ?></dd>
                    <dt class="">Điểm đón</dt>
                    <dd class="border-bottom pb-2"><?= isset($pickup_zone) ? $pickup_zone : "" ?></dd>
                    <dt class="">Điểm xuống</dt>
                    <dd class="border-bottom pb-2"><?= isset($drop_zone) ? $drop_zone : "" ?></dd>
                    <dt class="">Tên KH</dt>
                    <dd class="border-bottom pb-2">
                    <?php
                    $fullname = "";
                    if (isset($firstname) && isset($middlename) && isset($lastname)) {
                        $fullname = $firstname . " " . $middlename . " " . $lastname;
                    } elseif (isset($firstname) && isset($lastname)) {
                        $fullname = $firstname . " " . $lastname;
                    }
                    echo $fullname;
                ?>
                    </dd>
                    <dt class="">Số điện thoại KH</dt>
                    <dd class="border-bottom pb-2"><?= isset($contact) ? $contact : "" ?></dd>
                    <dt class="">Trạng thái</dt>
                    <dd class="border-bottom pb-2">
                        <?php 
                            switch($status){
                                case 0:
                                    echo "<span class='badge badge-secondary bg-gradient-secondary px-3 rounded-pill'>Pending</span>";
                                    break;
                                case 1:
                                    echo "<span class='badge badge-primary bg-gradient-primary px-3 rounded-pill'>Driver Confirmed</span>";
                                    break;
                                case 2:
                                    echo "<span class='badge badge-warning bg-gradient-warning px-3 rounded-pill'>Picked-up</span>";
                                    break;
                                case 3:
                                    echo "<span class='badge badge-success bg-gradient-success px-3 rounded-pill'>Dropped off</span>";
                                    break;
                                case 4:
                                    echo "<span class='badge badge-danger bg-gradient-danger px-3 rounded-pill'>Cancelled</span>";
                                    break;
                            }
                        ?>
                    </dd>
                </dl>
            </fieldset>
        </div>
    </div>
    
    <!-- <div class="clear-fix my-3"></div> -->
    <div class="text-right">
        <?php if(isset($status) && $status == 0): ?>
        <button class="btn btn-primary btn-flat bg-gradient-primary" type="button" id="confirm_booking">Confirm Booking</button>
        <?php elseif(isset($status) && $status == 1): ?>
        <button class="btn btn-warning btn-flat bg-gradient-warning" type="button" id="pickup_booking">Picked Up</button>
        <?php elseif(isset($status) && $status == 2): ?>
        <button class="btn btn-success btn-flat bg-gradient-success" type="button" id="dropoff_booking">Dropped Off</button>
        <?php endif; ?>
        <button class="btn btn-dark btn-flat bg-gradient-dark" type="button" data-dismiss="modal"><i class="fa fa-times"></i> Close</button>
    </div>
</div>
<script>
    $(function(){
        $('#confirm_booking').click(function(){
            _conf("Are you sure to confirm this booking [Ref. Code: <b><?= isset($ref_code) ? $ref_code : "" ?></b>]?", "update_booking_status",["<?= isset($id) ? $id : "" ?>",1])
        })
        $('#pickup_booking').click(function(){
            _conf("Mark [Ref. Code: <b><?= isset($ref_code) ? $ref_code : "" ?></b>] booking as Picked Up?", "update_booking_status",["<?= isset($id) ? $id : "" ?>",2])
        }) 
        $('#dropoff_booking').click(function(){
            _conf("Mark [Ref. Code: <b><?= isset($ref_code) ? $ref_code : "" ?></b>] booking as Dropped Off?", "update_booking_status",["<?= isset($id) ? $id : "" ?>",3])
        })
    })
    function update_booking_status($id,$status){
        start_loader();
		$.ajax({
			url:_base_url_+"classes/Master.php?f=update_booking_status",
			method:"POST",
			data:{id: $id,status:$status},
			dataType:"json",
			error:err=>{
				console.log(err)
				alert_toast("An error occured.",'error');
				end_loader();
			},
			success:function(resp){
				if(typeof resp== 'object' && resp.status == 'success'){
					location.reload();
				}else{
					alert_toast("An error occured.",'error');
					end_loader();
				}
			}
		})
    }
</script>