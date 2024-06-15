<?php
ob_start();
ini_set('date.timezone','Asia/Manila');
date_default_timezone_set('Asia/Manila');
session_start();

require_once('initialize.php');
require_once('classes/DBConnection.php');
require_once('classes/SystemSettings.php');
$db = new DBConnection;
$conn = $db->conn;

function redirect($url=''){
	if(!empty($url))
	echo '<script>location.href="'.base_url .$url.'"</script>';
}
function validate_image($file){
    $file = explode("?",$file)[0];
	if(!empty($file)){
			// exit;
		if(is_file(base_app.$file)){
			return base_url.$file;
		}else{
			return base_url.'uploads/cabicon.png';
		}
	}else{
		return base_url.'uploads/cabicon.png';
	}
}
function isMobileDevice(){
    $aMobileUA = array(
        '/iphone/i' => 'iPhone', 
        '/ipod/i' => 'iPod', 
        '/ipad/i' => 'iPad', 
        '/android/i' => 'Android', 
        '/blackberry/i' => 'BlackBerry', 
        '/webos/i' => 'Mobile'
    );

    //Return true if Mobile User Agent is detected
    foreach($aMobileUA as $sMobileKey => $sMobileOS){
        if(preg_match($sMobileKey, $_SERVER['HTTP_USER_AGENT'])){
            return true;
        }
    }
    //Otherwise return false..  
    return false;
}
function upload_image($file_input, $upload_dir = 'uploads/', $allowed_types = array('jpg', 'jpeg', 'png', 'gif'), $max_size = 2048)
{
    // Đường dẫn tuyệt đối đến thư mục upload
    $upload_path = base_app . $upload_dir;
    if (!is_dir($upload_path)) {
        mkdir($upload_path, 0755, true); // Tạo thư mục nếu chưa tồn tại
    }

    $file_name = $file_input['name']; // Lấy tên file
    $file_tmp = $file_input['tmp_name']; // Lấy đường dẫn tạm thời của file
    $file_size = $file_input['size']; // Lấy kích thước file
    $file_type = strtolower(pathinfo($file_name, PATHINFO_EXTENSION)); // Lấy định dạng file và chuyển thành chữ thường

    // Kiểm tra định dạng file
    if (!in_array($file_type, $allowed_types)) {
        return array('status' => false, 'message' => 'Định dạng file không hợp lệ. Vui lòng chọn một trong các định dạng: ' . implode(', ', $allowed_types));
    }

    // Kiểm tra kích thước file
    if ($file_size > $max_size * 1024) {
        return array('status' => false, 'message' => 'Kích thước file vượt quá giới hạn cho phép (' . $max_size . 'KB)');
    }

    // Tạo tên file mới duy nhất
    $new_file_name = uniqid() . '.' . $file_type;
    $target_file = $upload_path . $new_file_name; // Đường dẫn tới file mới

    // Di chuyển file từ thư mục tạm tới vị trí đích
    if (move_uploaded_file($file_tmp, $target_file)) {
        return array('status' => true, 'file_name' => $new_file_name, 'file_path' => $upload_dir . $new_file_name);
    } else {
        return array('status' => false, 'message' => 'Có lỗi xảy ra trong quá trình upload file');
    }
}
ob_end_flush();
?>