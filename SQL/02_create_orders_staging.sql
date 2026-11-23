
-- Menggunakan database proyek Olist
USE olist_ecommerce;

-- Membuat tabel penampung data orders
CREATE TABLE IF NOT EXISTS olist_orders_raw (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(50),
    order_purchase_timestamp VARCHAR(50),
    order_approved_at VARCHAR(50),
    order_delivered_carrier_date VARCHAR(50),
    order_delivered_customer_date VARCHAR(50),
    order_estimated_delivery_date VARCHAR(50)
);
