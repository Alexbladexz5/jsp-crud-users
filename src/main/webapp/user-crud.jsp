<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
	<title>CRUD de Usuarios</title>
	
	<!-- Hecho por Alejandro Berenguel Bustos -->
	
	<link href="https://use.fontawesome.com/releases/v5.13.0/css/all.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/libs/sbadmin/css/sb-admin-2.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/libs/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/admin-panel/main.css" rel="stylesheet">
	
</head>
<body style="background-color: #f8f9fc;">
	<!-- Contenedor -->
	<div class="container-fluid">

	    <!-- Cabecera -->
	    <div class="mt-4 justify-content-between mb-4">
	        <h1 class="h3 mb-0 text-gray-800">
	            <span>Usuarios</span>
	
			    <a href="" class="btn btn-dark btn-circle float-right" data-toggle="modal" data-target="#createMdl">
			        <i class="fas fa-plus"></i>
			    </a>
	        </h1>
	    </div>
	
	    <!-- Contenidos -->
	    <div class="row">
	        <div class="col-sm-12">
	            <!-- Contenido principal -->
	            <div class="d-flex align-items-center justify-content-center loading">
	            	<i class="fas svg-inline--fa fa-spinner fa-w-16 fa-spin fa-lg"></i>
	            </div>
	            
			    <div class="tabla-main">
			    	<div class="tabla-users">
			
			   		</div>
	            </div>
	            
	            <!-- Ventanas modales -->
	            <!-- Modal crear usuario -->
				<div class="modal fade" id="createMdl" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				    <div class="modal-dialog" role="document">
				      <div class="modal-content">
				        <div class="modal-header">
				          <h5 class="modal-title" id="exampleModalLabel">Nuevo usuario</h5>
				          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				            <span aria-hidden="true">&times;</span>
				          </button>
				        </div>
				        <div class="modal-body">
				        	<form action="" role="form" method="POST" id="createUserFrm">
				
						            <div class="row">
						              <div class="col-lg-6 form-group">
						                <div>
						                  <label for="name" class="form-fields">Nombre</label>
						                  <label class="mandatory-field">*</label>
						                  <input type="text" class="form-control" name="name" id="name-create" placeholder="Tu nombre aquí" value="">
						                </div>
						              </div>
						
						              <div class="col-lg-6 form-group">
						                <div>
						                  <label for="last_name" class="form-fields">Apellidos</label>
						                  <label class="mandatory-field">*</label>
						                  <input type="text" class="form-control" name="last_name" id="last-name-create" placeholder="Tus apellidos aquí" value="">
						                </div>
						              </div>
						            </div>
						            
						            <div class="row">
						              <div class="col-lg-4 form-group">
						                <div>
						                  <label for="age" class="form-fields">Edad</label>
						                  <label class="mandatory-field">*</label>
						                  <input type="number" class="form-control" name="age" id="age-create" placeholder="Ej: 25" value="" min="16" max="150">
						                </div>
						              </div>
						            </div>
						            
						            <div class="row">
						              <div class="col-lg-12 form-group">
						                <div>
						                  <label for="email" class="form-fields">Email</label>
						                  <label class="mandatory-field">*</label>
						                  <input type="email" class="form-control" name="email" id="email-create" placeholder="usuario@ejemplo.com" value="">
						                </div>
						              </div>
						            </div>
						
						            <div class="row">
						              <div class="col-lg-6 form-group">
						                <div>
						                  <label for="country" class="form-fields">País</label>
						                  <label class="mandatory-field">*</label>
						                  <input type="text" class="form-control" name="country" id="country-create" placeholder="Tu país aquí">
						                </div>
						              </div>
						              
						              <div class="col-lg-6 form-group">
						                <div>
						                  <label for="city" class="form-fields">Ciudad</label>
						                  <label class="mandatory-field">*</label>
						                  <input type="text" class="form-control" name="city" id="city-create" placeholder="Tu ciudad aquí">
						                </div>
						              </div>
						            </div>
						
						            <div class="buttons-form-submit d-flex justify-content-end">
						              <button type="button" class="btn btn-danger mr-1" data-dismiss="modal">Cerrar</button>
						              <button type="submit" href="" class="btn btn-dark" id="save-create">
						                Guardar
						                <i class="fas fa-spinner fa-spin d-none"></i>
						              </button>
						            </div>
				
				          		</form>
				        	</div>
				        
						</div>
					</div>
				</div>
				
	            <!-- Modal editar usuarios-->
				<div class="modal fade" id="editMdl" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				    <div class="modal-dialog" role="document">
				      <div class="modal-content">
				        <div class="modal-header">
				          <h5 class="modal-title" id="exampleModalLabel">Editar usuario</h5>
				          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				            <span aria-hidden="true">&times;</span>
				          </button>
				        </div>
				        <div class="modal-body">
				          <form action="" role="form" method="POST" id="editUserFrm">
							<input type="hidden" name="id" id="id-edit">
							
				            <div class="row">
				              <div class="col-lg-6 form-group">
				                <div>
				                  <label for="name" class="form-fields">Nombre</label>
				                  <label class="mandatory-field">*</label>
				                  <input type="text" class="form-control" name="name" id="name-edit" placeholder="Tu nombre aquí" value="">
				                </div>
				              </div>
				
				              <div class="col-lg-6 form-group">
				                <div>
				                  <label for="last_name" class="form-fields">Apellidos</label>
				                  <label class="mandatory-field">*</label>
				                  <input type="text" class="form-control" name="last_name" id="last-name-edit" placeholder="Tus apellidos aquí" value="">
				                </div>
				              </div>
				            </div>
				            
				            <div class="row">
				              <div class="col-lg-4 form-group">
				                <div>
				                  <label for="age" class="form-fields">Edad</label>
				                  <label class="mandatory-field">*</label>
				                  <input type="number" class="form-control" name="age" id="age-edit" value="" min="16" max="150">
				                </div>
				              </div>
				            </div>
				            
				            <div class="row">
				              <div class="col-lg-12 form-group">
				                <div>
				                  <label for="email" class="form-fields">Email</label>
				                  <label class="mandatory-field">*</label>
				                  <input type="email" class="form-control" name="email" id="email-edit" placeholder="usuario@ejemplo.com" value="">
				                </div>
				              </div>
				            </div>
				            
				            <div class="row">
				              <div class="col-lg-6 form-group">
				                <div>
				                  <label for="country" class="form-fields">País</label>
				                  <label class="mandatory-field">*</label>
				                  <input type="text" class="form-control" name="country" id="country-edit">
				                </div>
				              </div>
				              
				              <div class="col-lg-6 form-group">
				                <div>
				                  <label for="city" class="form-fields">Ciudad</label>
				                  <label class="mandatory-field">*</label>
				                  <input type="text" class="form-control" name="city" id="city-edit">
				                </div>
				              </div>
				            </div>
				
				            <div class="buttons-form-submit d-flex justify-content-end">
				              <button type="button" class="btn btn-danger mr-1" data-dismiss="modal">Cerrar</button>
				              <button type="submit" href="" class="btn btn-dark" id="save-edit">
				                Guardar
				                <i class="fas fa-spinner fa-spin d-none"></i>
				              </button>
				            </div>
				
				          </form>
				        </div>
				        
				      </div>
				    </div>
				  </div>
				  
				<!-- Modal -->
				<div class="modal animated zoomIn" id="deleteMdl" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
				     aria-hidden="true">
				    <div class="modal-dialog" role="document">
				        <div class="modal-content">
				            <div class="modal-header">
				                <h5 class="modal-title text-inspinia text-primary" id="exampleModalLabel">Eliminar usuario</h5>
				                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				                    <span aria-hidden="true">&times;</span>
				                </button>
				            </div>
				            <div class="modal-body">
				                <form action="deleteUser" role="form" method="POST" id="deleteUserFrm">
				                	<input type="hidden" name="id" id="id-delete">
				                    <p>¿Está seguro de eliminar este usuario?</p>
				
				                    <div class="buttons-form-submit d-flex justify-content-end">
				                        <button type="button" class="btn btn-secondary mr-1" data-dismiss="modal">Cerrar</button>
				                        <button type="submit" class="btn btn-primary btn-danger" id="save-delete">
				                            Eliminar
				                            <i class="fas fa-trash-alt"></i>
				                        </button>
				                    </div>
				
				                </form>
				            </div>
				        </div>
				    </div>
				</div>
	            
	            
	            
	            
	        </div>
	    </div>
	    
	</div>
	
	<!-- Bootstrap core JavaScript-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.4.0/sweetalert2.all.min.js" integrity="sha512-oTE6Gwi026OvpTsIUmeIA4+Q3DfI/m0ejEbpd1+qDxngi14bMVH249Z5UJVvKSHeSDmlBtmhtRB+HXySaSCp9Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="${pageContext.request.contextPath}/libs/datatables/jquery.dataTables.min.js"></script>
    <script src="${pageContext.request.contextPath}/libs/datatables/dataTables.bootstrap4.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/admin-panel/users_crud.js"></script>

    <script>
        function editUserCrud(user){
            $("#editUserFrm #id-edit").val(user.id);
            $("#editUserFrm #name-edit").val(user.name);
            $("#editUserFrm #last-name-edit").val(user.last_name);
            $("#editUserFrm #age-edit").val(user.age);
            $("#editUserFrm #email-edit").val(user.email);
            $("#editUserFrm #country-edit").val(user.country);
            $("#editUserFrm #city-edit").val(user.city);
        }

        function deleteUserCrud(user){
            $("#deleteUserFrm #id-delete").val(user.id);
        }
    </script>
</body>
</html>