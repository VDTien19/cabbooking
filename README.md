Sử dụng thư viện Summernote để cấu hình một trình soạn thảo WYSIWYG (What You See Is What You Get) trên các phần tử HTML có class summernote.
Cụ thể, đoạn code này:
Chọn tất cả các phần tử HTML có class summernote bằng jQuery selector $('.summernote').
Áp dụng plugin Summernote lên các phần tử đó, với các cấu hình sau:
height: 200: Thiết lập chiều cao của trình soạn thảo là 200 pixel.
toolbar: Cấu hình thanh công cụ của trình soạn thảo, bao gồm các nhóm công cụ như:
style: Các tùy chọn về kiểu chữ (bold, italic, underline, ...)
font: Các tùy chọn về font chữ
fontsize: Các tùy chọn về kích cỡ chữ
color: Các tùy chọn về màu sắc
para: Các tùy chọn về định dạng đoạn văn (danh sách, đoạn văn, ...)
table: Các tùy chọn về bảng
view: Các tùy chọn về chức năng xem (undo, redo, full screen, ...)