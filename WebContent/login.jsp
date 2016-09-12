<%@page import="model.Usuario"%>
<%! private Usuario userLog;%>
<%  
    userLog=(Usuario) request.getSession().getAttribute("userLog"); 
    if(!(userLog==null))
    {
       response.sendRedirect("index.jsp");
    }
%>
<div class="container">
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<div class="login-panel panel panel-default">
				<div class="panel-heading" align="center">
						<h3 class="panel-title">Printer Solution ACGM</h3>
				</div>
				<div class="panel-body">
					<form name="forma" id="forma" method="post" action="Login">
						<fieldset>

							<div class="form-group" align="center">
									<img src="img/soporte.png" WIDTH=150 HEIGHT=150><br>
								<div id="divError" class="alert alert-danger"
									style="display: none"></div>
								<input class="form-control" placeholder="Usuario" name="txtUser"
									type="text" autofocus>
							</div>

							<div class="form-group">
								<input class="form-control" placeholder="Password"
									name="txtPassword" type="password" value="">
							</div>
							<!-- Change this to a button or input when using this as a form -->
							<input type="submit" class="btn btn-lg btn-success btn-block"
								value="Ingresar" />
						</fieldset>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- jQuery -->
<script src="../bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- Metis Menu Plugin JavaScript -->
<script src="bower_components/metisMenu/dist/metisMenu.min.js"></script>
<!-- Custom Theme JavaScript -->
<script src="dist/js/sb-admin-2.js"></script>
<%
String error=null;
error= (String) request.getSession().getAttribute("errorInicio");
if(!(error==null))
{
%>
<script>
    document.getElementById("divError").innerHTML="<center><%=error%></center>";
    document.getElementById("divError").style.display='block';  
</script>
<%
    request.getSession().removeAttribute("errorInicio");
}
%>