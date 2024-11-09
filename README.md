# SmartKho - Ứng dụng Quản Lý Kho Thông Minh

SmartKho là một giải pháp quản lý kho toàn diện, giúp tự động hóa các hoạt động nhập/xuất kho và kiểm kê, nhằm tối ưu hóa hiệu suất và giảm thiểu sai sót trong quy trình quản lý kho. Dự án này bao gồm Web Dashboard cho quản lý, Ứng dụng Di Động cho nhân viên kho và Backend API với các công nghệ chính: NestJS, ReactJS, Flutter và MongoDB.

## Mục Tiêu

SmartKho hỗ trợ các doanh nghiệp trong việc:

- Theo dõi tồn kho chính xác và kịp thời.
- Tối ưu hóa quy trình nhập/xuất kho.
- Giảm thiểu rủi ro hết hàng và dư thừa hàng hóa.
- Đơn giản hóa thao tác kiểm kê và báo cáo cho nhân viên kho.

## Tính Năng

### 1. Tính Năng Web Dashboard (Dành cho Quản Lý)

Web Dashboard là công cụ quản trị, giúp quản lý có thể điều hành và giám sát toàn bộ hoạt động kho với các tính năng sau:

- **Quản lý Người Dùng**:

  - Thêm, sửa, xóa tài khoản người dùng.
  - Phân quyền người dùng với vai trò (Admin hoặc Nhân viên Kho).

- **Quản lý Sản Phẩm**:

  - Thêm mới sản phẩm với thông tin chi tiết như SKU, tên, mô tả, danh mục, số lượng tồn kho và mức tồn kho tối thiểu.
  - Cập nhật hoặc xóa thông tin sản phẩm khi cần thiết.

- **Quản lý Giao Dịch**:

  - Xem và phê duyệt các giao dịch nhập/xuất kho.
  - Thống kê giao dịch theo loại, sản phẩm và thời gian để nắm bắt tình hình kho.

- **Quản lý Lịch Sử Giao Dịch**:

  - Theo dõi lịch sử giao dịch để có cái nhìn tổng quan về hoạt động của kho.

- **Quản lý Nhà Cung Cấp**:

  - Thêm, sửa, xóa thông tin nhà cung cấp sản phẩm.

- **Báo Cáo và Thống Kê**:
  - Xem báo cáo tồn kho chi tiết, phát hiện sản phẩm hết hàng hoặc sắp hết hàng.
  - Hiển thị biểu đồ thống kê lịch sử nhập/xuất và tình trạng tồn kho.

### 2. Tính Năng Ứng Dụng Di Động (Dành cho Nhân Viên Kho)

Ứng dụng di động hỗ trợ nhân viên kho trong việc quản lý các công việc hàng ngày, giúp tăng hiệu suất làm việc và giảm thiểu sai sót:

- **Đăng Nhập**:

  - Đăng nhập an toàn cho nhân viên với tài khoản cá nhân.

- **Quét Mã Vạch**:

  - Hỗ trợ quét mã vạch nhanh chóng khi nhập hoặc xuất hàng hóa.

- **Nhập Kho**:

  - Ghi nhận số lượng sản phẩm nhập kho sau khi quét mã vạch và có thể thêm ghi chú cho giao dịch.

- **Xuất Kho**:

  - Xác nhận xuất hàng bằng cách quét mã vạch và ghi nhận số lượng sản phẩm xuất kho.

- **Kiểm Kê Kho**:

  - Thực hiện kiểm kê kho, ghi nhận và đối chiếu số lượng thực tế.

- **Xem Thông Tin Sản Phẩm**:
  - Hiển thị chi tiết sản phẩm bao gồm tên, SKU, mô tả và số lượng tồn kho hiện tại sau khi quét mã vạch.

> **Lưu ý:** Chức năng nhận thông báo sẽ được tích hợp trong các phiên bản sau.

## Công Nghệ Sử Dụng

- **Frontend Mobile**: Flutter
- **Frontend Web**: ReactJS
- **Backend**: NestJS
- **Cơ sở Dữ Liệu**: MongoDB
