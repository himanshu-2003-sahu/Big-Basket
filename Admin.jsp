<%@page import="java.util.List"%>
<%@page import="com.himanshu.MyShoppingBasket.entities.Category"%>
<%@page import="com.himanshu.MyBigBasket.helper.FactoryProvider"%>
<%@page import="com.himanshu.Dao.CategoryDao"%>
<%@page import="com.himanshu.MyShoppingBasket.entities.User" %>
<%
    User user = (User) session.getAttribute("current_user");
    if (user == null) {
        session.setAttribute("message", "You are not logged in!! Please login first.");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (!user.getUserType().equals("admin")) {
            session.setAttribute("message", "You are not an admin! Access denied.");
            response.sendRedirect("login.jsp");
            return;
        }
    }
%>

<%@page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Admin Panel</title>
        <%@ include file="component/common_css_js.jsp" %>
        <style>
            .custom-bg {
                background: #673ab7!important;
            }

            .admin .card {
                border: 1px solid #673ab7;
            }

            .admin .card:hover {
                background: #e2e2e2;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <%@ include file="component/navbar.jsp" %>
        <!-- Add the line here -->
        <!-- Your existing code starts here -->
        <div class="container admin">
            <div class="container-fluid mt-3">
                <%@include file="component/message.jsp" %>
            </div>
            <div class="row mt-3">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="Image/icons/team.png" alt="user_icon">
                            </div>
                            <h1>2342</h1>
                            <h1 class="text-uppercase text-muted">Users</h1>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="Image/icons/menu.png" alt="user_icon">
                            </div>
                            <h1>6789</h1>
                            <h1 class="text-uppercase text-muted">Categories</h1>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="Image/icons/delivery-box.png" alt="user_icon">
                            </div>
                            <h1>2345</h1>
                            <h1 class="text-uppercase text-muted">Products</h1>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-category-modal">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="Image/icons/apps.png" alt="user_icon">
                            </div>
                            <p>Click here to add new Categories</p>
                            <h1 class="text-uppercase text-muted">Add Category</h1>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-product-modal">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="Image/icons/add-cart.png" alt="user_icon">
                            </div>
                            <p class="mt-2">Click here to add Products</p>
                            <h1 class="text-uppercase text-muted">Add Products</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- add category modal -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Category Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!-- Form to add category details -->
                        <form action="ProductOperationServlet" method="post">
                            <input type="hidden" name="operation" value="addcategory">
                            <div class="form-group">
                                <input type="text" class="form-control" name="cName" placeholder="Enter title of Categories" required />
                            </div>
                            <!-- category description-->
                            <div class="form-group">
                                <textarea style="height: 150px;" class="form-control" placeholder="Enter Category  Description" name="cDesc"></textarea>
                            </div>

                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Category</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </form>
                        <!-- End of form -->
                    </div>
                </div>
            </div>
        </div>
        <!-- end category modal -->

        <!-- add product modal -->
        <div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Products Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!-- Form to add product details -->
                        <form action="ProductOperationServlet" method="post">
                            <input type="hidden" name="operation" value="addproduct">
                            <div class="form-group">
                                <input type="text" class="form-control" name="pName" placeholder="Enter title of products" required />
                            </div>
                            <!-- prdouct description -->
                            <div class="form-group">
                                <textarea style="height: 150px;" class="form-control" placeholder="Enter products Description" name="pDesc"></textarea>
                            </div>
                            <!-- product price -->
                            <div class="form-group">
                                <input type="number" class="form-control" name="pPrice" placeholder="Enter price of products" required />
                            </div>

                            <!-- product discount -->
                            <div class="form-group">
                                <input type="number" class="form-control" name="pDiscount" placeholder="Enter product discount" required />
                            </div>

                            <!-- product quantity -->
                            <div class="form-group">
                                <input type="number" class="form-control" name="pQuantity" placeholder="Enter product Quantity" required />
                            </div>

                            <!-- product category -->
                            <%      CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                                List<Category> list = cdao.getCategories();


                            %>



                            <div class="form-group">
                                <select name="catId" class="form-control" id="">

                                    <%                       for (Category c : list) {
                                    %>
                                    <option value="<%=c.getCategoryId()%>"> <%=c.getCategoryTitle()%></option>


                                    <% }%>
                                </select>


                            </div>

                            <!-- product Images -->

                            <div class="form-group">
                                <label for="pPic">Select picture of products</label>
                                <br>
                                <input type="file" id="pPic" name="pPic"  required />
                            </div>


                            <!-- submit button -->
                            <div class="container tetx-center">

                                <button class="btn btn-outline-success">Add product</button>
                            </div>





                            <!-- Add other fields as needed -->
                            <div class="container text-center">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </form>
                        <!-- End of form -->
                    </div>
                </div>
            </div>
        </div>
        <!-- end product modal -->
    </body>
</html>








