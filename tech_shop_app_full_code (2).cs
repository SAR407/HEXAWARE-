// Full TechShop 
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;

namespace TechShopApp
{
    public class Customer
    {
        private int customerID;
        private string firstName;
        private string lastName;
        private string email;
        private string phone;
        private string address;

        public Customer(int id, string fn, string ln, string em, string ph, string addr)
        {
            CustomerID = id;
            FirstName = fn;
            LastName = ln;
            Email = em;
            Phone = ph;
            Address = addr;
        }

        public int CustomerID
        {
            get { return customerID; }
            set
            {
                if (value <= 0)
                    throw new InvalidDataException("Customer ID must be positive");
                customerID = value;
            }
        }

        public string FirstName
        {
            get { return firstName; }
            set
            {
                if (string.IsNullOrWhiteSpace(value))
                    throw new InvalidDataException("First name is required");
                firstName = value;
            }
        }

        public string LastName
        {
            get { return lastName; }
            set
            {
                if (string.IsNullOrWhiteSpace(value))
                    throw new InvalidDataException("Last name is required");
                lastName = value;
            }
        }

        public string Email
        {
            get { return email; }
            set
            {
                if (!value.Contains("@"))
                    throw new InvalidDataException("Invalid email");
                email = value;
            }
        }

        public string Phone
        {
            get { return phone; }
            set
            {
                if (value.Length != 10)
                    throw new InvalidDataException("Phone must be 10 digits");
                phone = value;
            }
        }

        public string Address
        {
            get { return address; }
            set
            {
                if (string.IsNullOrWhiteSpace(value))
                    throw new InvalidDataException("Address is required");
                address = value;
            }
        }

        public void UpdateCustomerInfo(string email, string phone, string address)
        {
            Email = email;
            Phone = phone;
            Address = address;
        }

        public void GetCustomerDetails()
        {
            Console.WriteLine($"{CustomerID}: {FirstName} {LastName}, {Email}, {Phone}, {Address}");
        }
    }

    public class Product
    {
        private int productID;
        private string productName;
        private string description;
        private decimal price;
        private int quantity;

        public int ProductID
        {
            get { return productID; }
            set
            {
                if (value <= 0)
                    throw new InvalidDataException("Product ID must be positive");
                productID = value;
            }
        }

        public string ProductName
        {
            get { return productName; }
            set
            {
                if (string.IsNullOrWhiteSpace(value))
                    throw new InvalidDataException("Product name is required");
                productName = value;
            }
        }

        public string Description
        {
            get { return description; }
            set
            {
                if (string.IsNullOrWhiteSpace(value))
                    throw new InvalidDataException("Description is required");
                description = value;
            }
        }

        public decimal Price
        {
            get { return price; }
            set
            {
                if (value < 0)
                    throw new InvalidDataException("Price cannot be negative");
                price = value;
            }
        }

        public int Quantity
        {
            get { return quantity; }
            set
            {
                if (value < 0)
                    throw new InvalidDataException("Quantity cannot be negative");
                quantity = value;
            }
        }

        public void GetProductDetails()
        {
            Console.WriteLine($"ID: {ProductID}, Name: {ProductName}, Price: {Price:C}, InStock: {Quantity}");
        }

        public void UpdateProductInfo(decimal newPrice, string desc)
        {
            if (newPrice < 0) throw new InvalidDataException("Price can't be negative");
            Price = newPrice;
            Description = desc;
        }

        public bool IsProductInStock() => Quantity > 0;
    }

    public class Inventory
    {
        private int inventoryID;
        private Product product;
        private int quantityInStock;
        private DateTime lastStockUpdate;

        public int InventoryID
        {
            get { return inventoryID; }
            set
            {
                if (value <= 0)
                    throw new InvalidDataException("Inventory ID must be positive");
                inventoryID = value;
            }
        }

        public Product Product
        {
            get { return product; }
            set
            {
                if (value == null)
                    throw new InvalidDataException("Product cannot be null");
                product = value;
            }
        }

        public int QuantityInStock
        {
            get { return quantityInStock; }
            set
            {
                if (value < 0)
                    throw new InvalidDataException("Quantity in stock cannot be negative");
                quantityInStock = value;
            }
        }

        public DateTime LastStockUpdate
        {
            get { return lastStockUpdate; }
            set { lastStockUpdate = value; }
        }

        public Product GetProduct() => Product;
        public int GetQuantityInStock() => QuantityInStock;

        public void AddToInventory(int qty)
        {
            QuantityInStock += qty;
            LastStockUpdate = DateTime.Now;
        }

        public void RemoveFromInventory(int qty)
        {
            if (QuantityInStock < qty)
                throw new InsufficientStockException("Not enough stock");
            QuantityInStock -= qty;
            LastStockUpdate = DateTime.Now;
        }

        public void UpdateStockQuantity(int newQty)
        {
            QuantityInStock = newQty;
            LastStockUpdate = DateTime.Now;
        }

        public bool IsProductAvailable(int qty) => QuantityInStock >= qty;
        public decimal GetInventoryValue() => Product.Price * QuantityInStock;
    }
    public class Order
    {
        private int orderID;
        private Customer customer;
        private DateTime orderDate;
        private decimal totalAmount;
        private string status;
        public List<OrderDetail> Items { get; set; } = new List<OrderDetail>();

        public int OrderID
        {
            get { return orderID; }
            set
            {
                if (value <= 0)
                    throw new InvalidDataException("Order ID must be positive");
                orderID = value;
            }
        }

        public Customer Customer
        {
            get { return customer; }
            set
            {
                if (value == null)
                    throw new IncompleteOrderException("Order must have a valid customer");
                customer = value;
            }
        }

        public DateTime OrderDate
        {
            get { return orderDate; }
            set { orderDate = value; }
        }

        public decimal TotalAmount
        {
            get { return totalAmount; }
            set { totalAmount = value; }
        }

        public string Status
        {
            get { return status; }
            set { status = value; }
        }

        public void CalculateTotalAmount()
        {
            TotalAmount = Items.Sum(i => i.CalculateSubtotal());
        }

        public void GetOrderDetails()
        {
            Console.WriteLine($"Order #{OrderID}, Customer: {Customer.FirstName}, Total: {TotalAmount:C}");
            foreach (var item in Items)
                item.GetOrderDetailInfo();
        }

        public void UpdateOrderStatus(string newStatus) => Status = newStatus;

        public void CancelOrder()
        {
            foreach (var item in Items)
                item.Product.Quantity += item.Quantity;
            Items.Clear();
            Status = "Cancelled";
        }
    }

    public class OrderDetail
    {
        public int OrderDetailID { get; set; }
        public Order Order { get; set; }
        public Product Product { get; set; }
        public int Quantity { get; set; }
        public decimal Discount { get; set; } = 0;

        public decimal CalculateSubtotal() => (Product.Price * Quantity) * (1 - Discount);

        public void GetOrderDetailInfo()
        {
            Console.WriteLine($"  Product: {Product.ProductName}, Qty: {Quantity}, Subtotal: {CalculateSubtotal():C}");
        }

        public void UpdateQuantity(int newQty)
        {
            if (newQty <= 0) throw new InvalidDataException("Quantity must be positive");
            Quantity = newQty;
        }

        public void AddDiscount(decimal percent)
        {
            if (percent < 0 || percent > 1) throw new InvalidDataException("Invalid discount");
            Discount = percent;
        }
    }

    
    public class InvalidDataException : Exception { public InvalidDataException(string msg) : base(msg) { } }
    public class InsufficientStockException : Exception { public InsufficientStockException(string msg) : base(msg) { } }
    public class IncompleteOrderException : Exception { public IncompleteOrderException(string msg) : base(msg) { } }

    // Task 7: DB Connectivity
    public static class DBConnUtil
    {
        private static readonly string connStr = "Data Source=localhost;Initial Catalog=TechShop;Integrated Security=True";

        public static SqlConnection GetConnection()
        {
            var conn = new SqlConnection(connStr);
            conn.Open();
            return conn;
        }
    }

    
    public class Program
    {
        static List<Customer> customers = new();
        static List<Product> products = new();
        static List<Order> orders = new();

        public static void Main()
        {
            Console.WriteLine("Welcome to TechShop - Full System Demo");

            try
            {
                var customer = new Customer(1, "Patty", "Kumar", "patty@email.com", "9876543210", "Chennai");
                customers.Add(customer);

                var product = new Product { ProductID = 1, ProductName = "Laptop", Description = "Gaming Laptop", Price = 70000, Quantity = 5 };
                products.Add(product);

                var order = new Order { OrderID = 1001, Customer = customer, OrderDate = DateTime.Now, Status = "Processing" };
                var orderDetail = new OrderDetail { OrderDetailID = 1, Order = order, Product = product, Quantity = 2 };
                order.Items.Add(orderDetail);
                order.CalculateTotalAmount();

                orders.Add(order);

                order.GetOrderDetails();
            }
            catch (InvalidDataException ex)
            {
                Console.WriteLine("Validation Error: " + ex.Message);
            }
            catch (InsufficientStockException ex)
            {
                Console.WriteLine("Stock Error: " + ex.Message);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Unexpected Error: " + ex.Message);
            }
        }
    }
} 
