<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Bill</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
    <style>
        body { min-height: 100vh; display: flex; background-color: #f8f9fa; }
        .sidebar { width: 250px; background: #0d6efd; color: #fff; flex-shrink: 0; }
        .sidebar .nav-link { color: #fff; padding: 12px 20px; font-size: 15px; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background: #0b5ed7; border-radius: 4px; }
        .sidebar h4 { padding: 20px; margin: 0; text-align: center; font-weight: bold; }
        .main-content { flex-grow: 1; padding: 30px; }
        .card { margin-bottom: 20px; }
        .table td input { width: 80px; }
        .total-panel { text-align: right; font-size: 1.2em; font-weight: bold; }
        @media (max-width: 768px) { .table td input { width: 100%; } }
    </style>
    <script>
        function filterCustomers() {
            let input = document.getElementById("customerSearch").value.toLowerCase();
            document.querySelectorAll("#customerTable tbody tr").forEach(row => {
                row.style.display = row.innerText.toLowerCase().includes(input) ? "" : "none";
            });
        }

        function selectCustomer(id, name) {
            document.getElementById("selectedCustomer").value = id;
            document.getElementById("customerDisplay").innerText = name;
            bootstrap.Modal.getInstance(document.getElementById("customerModal")).hide();
        }

        function addBook(id, title, price) {
            let table = document.getElementById("billItems"); let rows = table.querySelectorAll("tr"); let found = false;

            rows.forEach(row => {
                let hiddenId = row.querySelector("input[name='bookId']");
                if (hiddenId && hiddenId.value === id) {
                    let qtyInput = row.querySelector("input[name='quantity']");
                    qtyInput.value = parseInt(qtyInput.value) + 1;
                    found = true;
                }
            });

            if (!found) {
                let row = table.insertRow();
                row.innerHTML = `
    <td>${'${'}title}<input type="hidden" name="bookId" value="${'${'}id}"/></td>
    <td><input type="number" class="form-control" name="quantity" value="1" min="1" onchange="updateTotal()"/></td>
    <td><input type="text" class="form-control" name="price" value="${'${'}price}" readonly/></td>
    <td class="subtotal">${'${'}price}</td>
    <td><button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)">X</button></td>
`;
            }

            updateTotal();
        }

        function updateTotal() {
            let total = 0;
            document.querySelectorAll("#billItems tr").forEach(row => {
                let qty = parseFloat(row.querySelector("input[name='quantity']").value) || 0;
                let price = parseFloat(row.querySelector("input[name='price']").value) || 0;
                row.querySelector(".subtotal").innerText = (qty * price).toFixed(2);
                total += qty * price;
            });
            document.getElementById("total").value = total.toFixed(2);
        }
    </script>
</head>
<body>
<!-- Sidebar -->
<div class="sidebar d-flex flex-column p-3">
    <h4>PahanaEdu</h4>
    <hr class="bg-light">
    <ul class="nav nav-pills flex-column mb-auto">
        <li><a href="dashboard.jsp" class="nav-link"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
        <li><a href="BookServlet" class="nav-link"><i class="bi bi-book"></i> Books</a></li>
        <li><a href="CustomerServlet" class="nav-link"><i class="bi bi-people"></i> Customers</a></li>
        <li><a href="BillServlet" class="nav-link active"><i class="bi bi-receipt"></i> Billing</a></li>
        <li><a href="bill-history.jsp" class="nav-link"><i class="bi bi-clock-history"></i> Billing History</a></li>
    </ul>
    <hr class="bg-light">
    <a href="logout.jsp" class="nav-link"><i class="bi bi-box-arrow-right"></i> Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">
    <h2 class="mb-4">Create Bill</h2>

    <form method="post" action="BillServlet">
        <!-- Customer Section -->
        <div class="card">
            <div class="card-header bg-primary text-white">
                <i class="bi bi-person"></i> Customer
            </div>
            <div class="card-body">
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#customerModal">
                    Search & Select Customer
                </button>
                <span class="ms-3 fw-bold" id="customerDisplay">No customer selected</span>
                <input type="hidden" id="selectedCustomer" name="customerId" required>
            </div>
        </div>

        <!-- Book Section -->
        <div class="card">
            <div class="card-header bg-success text-white">
                <i class="bi bi-book"></i> Books
            </div>
            <div class="card-body">
                <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#bookModal">
                    Search & Add Books
                </button>
                <div class="table-responsive">
                    <table class="table table-bordered align-middle text-center">
                        <thead class="table-light">
                        <tr>
                            <th>Book</th>
                            <th>Qty</th>
                            <th>Price</th>
                            <th>Subtotal</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody id="billItems"></tbody>
                    </table>
                </div>
            </div>
        </div>


        <div class="d-flex justify-content-between align-items-center mb-4 total-panel">
            <label>Total:</label>
            <input type="text" class="form-control w-auto d-inline-block" id="total" name="total" readonly>
        </div>

        <div class="mb-3">
            <button type="submit" class="btn btn-primary"><i class="bi bi-check-lg"></i> Purchase</button>
            <a href="dashboard.jsp" class="btn btn-secondary"><i class="bi bi-x-lg"></i> Cancel</a>
        </div>
    </form>

    <!-- Customer Modal -->
    <div class="modal fade" id="customerModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Select Customer</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="text" id="customerSearch" class="form-control mb-3" placeholder="Search..." onkeyup="filterCustomers()">
                    <table class="table table-hover" id="customerTable">
                        <thead>
                        <tr><th>ID</th><th>Name</th><th>Email</th><th></th></tr>
                        </thead>
                        <tbody>
                        <c:forEach var="c" items="${customers}">
                            <tr>
                                <td>${c.id}</td>
                                <td>${c.name}</td>
                                <td>${c.email}</td>
                                <td><button type="button" class="btn btn-sm btn-primary" onclick="selectCustomer('${c.id}', '${c.name}')">Select</button></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Book Modal -->
    <div class="modal fade" id="bookModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Select Books</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="text" id="bookSearch" class="form-control mb-3" placeholder="Search..." onkeyup="
                            let val=this.value.toLowerCase();
                            document.querySelectorAll('#bookTable tbody tr').forEach(r=>r.style.display=r.innerText.toLowerCase().includes(val)?'':'none');
                        ">
                    <table class="table table-hover" id="bookTable">
                        <thead>
                        <tr><th>ID</th><th>Title</th><th>Price</th><th></th></tr>
                        </thead>
                        <tbody>
                        <c:forEach var="b" items="${books}">
                            <tr>
                                <td>${b.id}</td>
                                <td>${b.title}</td>
                                <td>${b.price}</td>
                                <td><button type="button" class="btn btn-sm btn-success" onclick="addBook('${b.id}', '${b.title}', '${b.price}')"><i class="bi bi-plus-lg"></i> Add</button></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
