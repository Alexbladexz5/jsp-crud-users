// Hecho por Alejandro Berenguel Bustos

// Mostrar lista con todos los usuarios
$(document).ready(load);

function load() {
	showAllUsers();
	
	// Cargar eventos del botón 'Guardar' de las ventanas modales. Es necesario para hacer las peticiones AJAX
    createUser();
	updateUser();
	destroyUser();
}

function showAllUsers() {
    var params = [];
    $.ajax({
        data: params,
        url: 'getUsers',
        type: 'get',

        success: function (response) {
            $table = `
                <div class="card">
                    <div class="card-body">
                        <table id="dt-users" class="table table-striped table-bordered table-responsive-md dts">
                            <thead>
                                <tr>
                                    <th class="text-center">Nombre</th>
                                    <th class="text-center">Apellidos</th>
                                    <th class="text-center">Correo</th>
                                    <th class="text-center">Edad</th>
                                    <th class="text-center">País</th>
                                    <th class="text-center">Ciudad</th>
                                    <th class="text-center">Acciones</th>
                                </tr>
                            </thead>
                            <tbody class="data-tbody">
                            
                            </tbody>
                        </table>
                    </div>
                </div>
            `;

            $(".tabla-users").append($table);

            response.forEach(function (data) {
                var tbody = "";

                if (data.update_at == null) {
                    data.update_at = "No disponible";
                }
                if (data.created_at == null) {
                    data.created_at = "No disponible";
                }

                tbody = `
                <tr class="text-center">
                    <td>${data.name}</td>
                    <td>${data.last_name}</td>
                    <td>${data.email}</td>
                    <td>${data.age}</td>
                    <td>${data.country}</td>
                    <td>${data.city}</td>
                    <td>
                        <a href="" class="edit-form-data" data-toggle="modal" data-target="#editMdl" onclick="editUserCrud(${JSON.stringify(data, ['id', 'name', 'last_name', 'email', 'age', 'country', 'city']).replace(/['"]+/g, '&quot;')})">
                            <i class="fas fa-edit" style="color: rgb(90,92,105)"></i>
                        </a>
                        <a href="" class="delete-form-data" data-toggle="modal" data-target="#deleteMdl" onclick="deleteUserCrud(${JSON.stringify(data, ['id']).replace(/['"]+/g, '&quot;')})">
                            <i class="fas fa-trash-alt"></i>
                        </a>
                    </td>
                </tr>
                `;

                $(".data-tbody").append(tbody);
            })

            if($.fn.DataTable) {
                $('.dts').DataTable({
                    language: {
                        url: 'libs/datatables/spanish.json'
                    },
                    columns: [
                        null,
                        null,
                        null,
                        null,
                        null,
                        null,
                        { orderable: false}
                    ]

                });
            }
            
            $('.loading').fadeOut('slow', function() {
				$('.loading')[0].style.setProperty('display', 'none', 'important');
				// $('.loading')[0].style.setProperty('opacity', '0.5');
			});
            
        },
        error: function (response) {
            console.log("No funciona");
        }

    })
}

function createUser() {
	$('#save-create').click(function(event) {
		// Necesario para no recargar la página web
		event.preventDefault();
		
		// Se muestra la pantalla de carga
		$('.loading').fadeIn('slow', function() {
			// Guardamos los datos del usuario en un objeto
			var user = {
		        'name': $('#name-create').val(),
		        'last_name': $('#last-name-create').val(),
		        'email': $('#email-create').val(),
		        'age': $('#age-create').val(),
		        'country': $('#country-create').val(),
		        'city': $('#city-create').val()
	    	};
	    	
	    	// Comprobación de que los datos no estén vacios
			if (!checkForm(user)) {
				// Se quita el loading y se muestra mensaje de error con SweetAlert2
				$('.loading').fadeOut('slow', function() {
					$('.loading')[0].style.setProperty('display', 'none', 'important');
					
					Swal.fire({
		                icon: 'error',
		                title: 'Usuario no válido',
		                text: 'Compruebe que estén bien los datos',
	            	});
				});
			} else {
				// Llamada AJAX para almacenar el nuevo usuario
				$.ajax({
					url: 'createUser',
	                type: 'post',
	                data: user,
	                success: function(response) {
                        // Cargar de nuevo la tabla con una llamada AJAX
                        $('.dts').DataTable().clear();
                        $('.dts').DataTable().destroy();
			            
			            $('.tabla-users').empty();
			            showAllUsers();
                        
                        // Efectos
                        $('#createMdl').modal('hide');
                        $('.loading').fadeOut('slow', function() {
							$('.loading')[0].style.setProperty('display', 'none', 'important');			
							$('#createUserFrm').trigger("reset");
							
							Swal.fire({
				                icon: 'success',
				                title: 'Usuario creado'
			            	});   
						});
	                },
	                error: function(response){
	                    $('.loading').fadeOut('slow', function() {
							$('.loading')[0].style.setProperty('display', 'none', 'important');
							
							Swal.fire({
	                            icon: 'error',
	                            title: 'Ups...',
	                            text: 'No se ha podido crear el usuario, intenténtelo más tarde.',
	                    	});
						});
	                }
				});
			}
		});
	});
}

function updateUser() {
	$('#save-edit').click(function(event) {
		// Necesario para no recargar la página web
		event.preventDefault();
		
		// Se muestra la pantalla de carga
		$('.loading').fadeIn('slow', function() {
			// Guardamos los datos del usuario en un objeto
			var user = {
				'id':  $('#id-edit').val(),
		        'name': $('#name-edit').val(),
		        'last_name': $('#last-name-edit').val(),
		        'email': $('#email-edit').val(),
		        'age': $('#age-edit').val(),
		        'country': $('#country-edit').val(),
		        'city': $('#city-edit').val()
	    	};
	    	
	    	// Comprobación de que los datos no estén vacios
			if (!checkForm(user)) {
				// Se quita el loading y se muestra mensaje de error con SweetAlert2
				$('.loading').fadeOut('slow', function() {
					$('.loading')[0].style.setProperty('display', 'none', 'important');
					
					Swal.fire({
		                icon: 'error',
		                title: 'Usuario no válido',
		                text: 'Compruebe que estén bien los datos',
	            	});
				});
			} else {
				// Llamada AJAX para almacenar el nuevo usuario
				$.ajax({
					url: 'editUser',
	                type: 'post',
	                data: user,
	                success: function(response) {
                        // Cargar de nuevo la tabla con una llamada AJAX
                        $('.dts').DataTable().clear();
                        $('.dts').DataTable().destroy();
			            
			            $('.tabla-users').empty();
			            showAllUsers();
                        
                        // Efectos
                        $('#editMdl').modal('hide');
                        $('.loading').fadeOut('slow', function() {
							$('.loading')[0].style.setProperty('display', 'none', 'important');			
							
							Swal.fire({
				                icon: 'success',
				                title: 'Usuario modificado'
			            	});
						});	                  
	                },
	                error: function(response){
	                    $('.loading').fadeOut('slow', function() {
							$('.loading')[0].style.setProperty('display', 'none', 'important');
							
							Swal.fire({
	                            icon: 'error',
	                            title: 'Ups...',
	                            text: 'No se ha podido editar el usuario, intenténtelo más tarde.',
	                    	});
						});
	                }
				});
			}
		});
	});
}

function destroyUser() {
	$('#save-delete').click(function(event) {
		// Necesario para no recargar la página web
		event.preventDefault();
		
		// Se muestra la pantalla de carga
		$('.loading').fadeIn('slow', function() {
			// Guardamos los datos del usuario en un objeto
			var user = {
				'id':  $('#id-delete').val()
	    	};
			
			// Llamada AJAX para almacenar el nuevo usuario
			$.ajax({
				url: 'deleteUser',
                type: 'post',
                data: user,
                success: function(response) {
                    // Cargar de nuevo la tabla con una llamada AJAX
                    $('.dts').DataTable().clear();
                    $('.dts').DataTable().destroy();
		            
		            $('.tabla-users').empty();
		            showAllUsers();
                    
                    // Efectos
                    $('#deleteMdl').modal('hide');
                    $('.loading').fadeOut('slow', function() {
						$('.loading')[0].style.setProperty('display', 'none', 'important');			
						
						Swal.fire({
			                icon: 'success',
			                title: 'Usuario eliminado'
		            	});
					});	                  
                },
                error: function(response){
                    $('.loading').fadeOut('slow', function() {
						$('.loading')[0].style.setProperty('display', 'none', 'important');
						
						Swal.fire({
                            icon: 'error',
                            title: 'Ups...',
                            text: 'No se ha podido eliminar el usuario, intenténtelo más tarde.',
                    	});
					});
                }
			});
		});
	});
}

// Función checkForm() para mandar false si un dato es vacio o nulo
function checkForm(form) {
	if (form.name == '' || form.name == null) {
		return false;
	}
	
	if (form.last_name == '' || form.last_name == null) {
		return false;
	}
	
	if (form.email == '' || form.email == null) {
		return false;
	}
	
	if (form.age == '' || form.age == null) {
		return false;
	}
	
	if (form.country == '' || form.country == null) {
		return false;
	}
	
	if (form.city == '' || form.city == null) {
		return false;
	}
	
	return true;
}