<!-----------  Importaciones -------------------->
	<%@page import="model.Usuario" %>
	<%@page import="controller.Inicio.Login" %>
	<%@page import="model.ModulosGrupos" %>
<!------------ Definicion de variables---------->
<%! 
	//Variables generales
	private Usuario userLog=null; 
%>
<!-----------  Asignacion  --------------------->
<%
//Prepacion del formulario
HttpSession sesion = request.getSession();
userLog= (Usuario)sesion.getAttribute("userLog");
%>
<div class="navbar-header">
       <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
           <span class="sr-only">Toggle navigation</span>
           <span class="icon-bar"></span>
           <span class="icon-bar"></span>
           <span class="icon-bar"></span>
       </button>
       <a class="navbar-brand" href="index.jsp">Inicio</a>
 </div>
   <!-- /.navbar-header -->

<ul class="nav navbar-top-links navbar-right">               
    <!-- /.dropdown -->
    <li class="dropdown">
        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
            <i class="fa fa-bell fa-fw"></i>  <i class="fa fa-caret-down"></i>
        </a>
        <ul class="dropdown-menu dropdown-alerts">
            <li>
                <a href="#">
                    <div>
                        <i class="fa fa-comment fa-fw"></i> Incidencias
                        <span class="pull-right text-muted small">4 minutes ago</span>
                    </div>
                </a>
            </li>
        </ul>
        <!-- /.dropdown-alerts -->
    </li>
    <!-- /.dropdown -->
    
     <!------------ ------/.PERFIL DE USUARIO -------------------------------->
    <li class="dropdown">
        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
            <i class="fa fa-user fa-fw"></i>  <i class="fa fa-caret-down"></i>
        </a>
        <ul class="dropdown-menu dropdown-user">
        	<%
        	String icono="";
        	if(userLog.getFoto().equals("0"))
        	{
        		icono="<i class='fa fa-user fa-fw'></i>";
        	}
        	else
        	{
        		icono="<img style=\"border-radius: 45%;\" src=\"img/fotosDePerfil/"+userLog.getFoto()+"\" widht=\"35px\" height=\"35px\">";
        	}
        	String carpeta=Login.Encripta("client_perfil");
        	String modulo=Login.Encripta("admin_perfil.jsp");
        	%>
            <li><a href="index.jsp?sec=<%=carpeta%>&mod=<%=modulo%>"> <%=icono %> <%=userLog.getUsuario()%></a>
            </li>
            <!--<li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
            </li>-->
            <li class="divider"></li>
            <li><a href="Logout?salir=salir"><i class="fa fa-sign-out fa-fw"></i> Cerrar sesion</a>
            </li>
        </ul>
        <!-- /.dropdown-user -->
    </li>
    <!-- /.dropdown -->
</ul>