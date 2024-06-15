<?php
require_once('../config.php');
Class Users extends DBConnection {
	private $settings;
	public function __construct(){
		global $_settings;
		$this->settings = $_settings;
		parent::__construct();
	}
	public function __destruct(){
		parent::__destruct();
	}
	public function save_users(){
		if(!isset($_POST['status']) && $this->settings->userdata('login_type') == 1){
			$_POST['status'] = 1;
		}
		extract($_POST);
		$oid = $id;
		$data = '';
		if(isset($oldpassword)){
			if(md5($oldpassword) != $this->settings->userdata('password')){
				return 4;
			}
		}
		$chk = $this->conn->query("SELECT * FROM `users` where username ='{$username}' ".($id>0? " and id!= '{$id}' " : ""))->num_rows;
		if($chk > 0){
			return 3;
			exit;
		}
		foreach($_POST as $k => $v){
			if(in_array($k,array('firstname','middlename','lastname','username','type'))){
				if(!empty($data)) $data .=" , ";
				$data .= " {$k} = '{$v}' ";
			}
		}
		if(!empty($password)){
			$password = md5($password);
			if(!empty($data)) $data .=" , ";
			$data .= " `password` = '{$password}' ";
		}

		if(empty($id)){
			$qry = $this->conn->query("INSERT INTO users set {$data}");
			if($qry){
				$id = $this->conn->insert_id;
				$this->settings->set_flashdata('success','User Details successfully saved.');
				$resp['status'] = 1;
			}else{
				$resp['status'] = 2;
			}

		}else{
			$qry = $this->conn->query("UPDATE users set $data where id = {$id}");
			if($qry){
				$this->settings->set_flashdata('success','User Details successfully updated.');
				if($id == $this->settings->userdata('id')){
					foreach($_POST as $k => $v){
						if($k != 'id'){
							if(!empty($data)) $data .=" , ";
							$this->settings->set_userdata($k,$v);
						}
					}
					
				}
				$resp['status'] = 1;
			}else{
				$resp['status'] = 2;
			}
			
		}

		if(isset($_FILES['img']) && $_FILES['img']['tmp_name'] != ''){
			$fname = 'uploads/'.strtotime(date('y-m-d H:i')).'_'.$_FILES['img']['name'];
			$move = move_uploaded_file($_FILES['img']['tmp_name'],'../'.$fname);
			if($move){
				try {
					$sql = "UPDATE users SET avatar = '$fname' WHERE id = $id";
					$query = $this->conn->query($sql);
					if($query && $id == $this->settings->userdata('id') && $this->settings->userdata('login_type') == 2){
						$this->settings->set_userdata('avatar', $fname);
						// if ($id == $this->settings->userdata('id') && $this->settings->userdata('login_type') == 2) {
						// }
						echo "Upload and save image successfully.";
					} else {
						echo "Error occurred while saving image to the database.";
					}
				} catch (Exception $e) {
					echo "Error occurred while saving image to the database: " . $e->getMessage();
				}
			} else {
				echo "Error occurred while uploading the image.";
			}
		} else {
			echo "No image file was uploaded.";
		}
		
		if(isset($resp['msg']))
		$this->settings->set_flashdata('success',$resp['msg']);
		return  $resp['status'];
	}
	public function delete_users(){
		extract($_POST);
		$avatar = $this->conn->query("SELECT avatar FROM users where id = '{$id}'")->fetch_array()['avatar'];
		$qry = $this->conn->query("DELETE FROM users where id = $id");
		if($qry){
			$this->settings->set_flashdata('success','User Details successfully deleted.');
			if(is_file(base_app.$avatar))
				unlink(base_app.$avatar);
			$resp['status'] = 'success';
		}else{
			$resp['status'] = 'failed';
		}
		return json_encode($resp);
	}

	// Clients
	public function save_client(){
		if(!empty($_POST['password']))
		$_POST['password'] = md5($_POST['password']);
		else
		unset($_POST['password']);
		if(isset($_POST['oldpassword'])){
			if($this->settings->userdata('id') > 0 && $this->settings->userdata('login_type') == 2){
				$get = $this->conn->query("SELECT * FROM `client_list` where id = '{$this->settings->userdata('id')}'");
				$res = $get->fetch_array();
				if($res['password'] != md5($_POST['oldpassword'])){
					return  json_encode([
						'status' =>'failed',
						'msg'=>' Current Password is incorrect.'
					]);
				}
			}
			unset($_POST['oldpassword']);
		}
		extract($_POST);
		$data = "";
		foreach($_POST as $k => $v){
			if(!in_array($k, array('id'))){
				if(!empty($data)) $data .= ", ";
				$data .= " `{$k}` = '{$v}' ";
			}
		}
		$check = $this->conn->query("SELECT * FROM `client_list` where email = '{$email}' and delete_flag ='0' ".(is_numeric($id) && $id > 0 ? " and id != '{$id}'" : "")." ")->num_rows;
		if($check > 0){
			$resp['status'] = 'failed';
			$resp['msg'] = ' Email already exists in the database.';
		}else{
			if(empty($id)){
				$sql = "INSERT INTO `client_list` set $data";
			}else{
				$sql = "UPDATE `client_list` set $data where id = '{$id}'";
			}
			$save = $this->conn->query($sql);
			if($save){
				$resp['status'] = 'success';
				$uid = empty($id) ? $this->conn->insert_id : $id;
				if(empty($id)){
					$resp['msg'] = " Account is successfully registered.";
				}else if($this->settings->userdata('id') == $id && $this->settings->userdata('login_type') == 2){
					$resp['msg'] = " Account Details has been updated successfully.";
					foreach($_POST as $k => $v){
						if(!in_array($k,['password'])){
							$this->settings->set_userdata($k,$v);
						}
					}
				}else{
					$resp['msg'] = " Client's Account Details has been updated successfully.";
				}


				if(isset($_FILES['img']) && $_FILES['img']['tmp_name'] != ''){
					$fname = 'uploads/clients/'.strtotime(date('y-m-d H:i')).'_'.$_FILES['img']['name'];
					$move = move_uploaded_file($_FILES['img']['tmp_name'],'../'.$fname);
					if($move){
						try {
							$sql = "UPDATE client_list SET image_path = '$fname' WHERE id = $id";
							$query = $this->conn->query($sql);
							if($query && $id == $this->settings->userdata('id') && $this->settings->userdata('login_type') == 2){
								$this->settings->set_userdata('image_path', $fname);
								// if ($id == $this->settings->userdata('id') && $this->settings->userdata('login_type') == 2) {
								// }
								echo "Upload and save image successfully.";
							} else {
								echo "Error occurred while saving image to the database.";
							}
						} catch (Exception $e) {
							echo "Error occurred while saving image to the database: " . $e->getMessage();
						}
					} else {
						echo "Error occurred while uploading the image.";
					}
				} else {
					echo "No image file was uploaded.";
				}
							
			}else{
				// $this->settings->set_flashdata('success',$resp['msg']);
				$resp['status'] = 'failed';
				if(empty($id)){
					$resp['msg'] = " Account has failed to register for some reason.";
				}else if($this->settings->userdata('id') == $id && $this->settings->userdata('login_type') == 2){
					$resp['msg'] = " Account Details has failed to update.";
				}else{
					$resp['msg'] = " Client's Account Details has failed to update.";
				}
			}
		}	
		
		if($resp['status'] == 'success')
		$this->settings->set_flashdata('success',$resp['msg']);
		return json_encode($resp);

	} 
	function delete_client(){
		extract($_POST);
		$del = $this->conn->query("UPDATE `client_list` set delete_flag = 1 where id='{$id}'");
		if($del){
			$resp['status'] = 'success';
			$resp['msg'] = ' Client Account has been deleted successfully.';
		}else{
			$resp['status'] = 'failed';
			$resp['msg'] = " Client Account has failed to delete";
		}
		if($resp['status'] =='success')
		$this->settings->set_flashdata('success',$resp['msg']);
		return json_encode($resp);
	}
	
}

$users = new users();
$action = !isset($_GET['f']) ? 'none' : strtolower($_GET['f']);
switch ($action) {
	case 'save':
		echo $users->save_users();
	break;
	case 'delete':
		echo $users->delete_users();
	break;
	case 'save_client':
		echo $users->save_client();
	break;
	case 'delete_client':
		echo $users->delete_client();
	break;
	break;
	default:
		// echo $sysset->index();
		break;
}