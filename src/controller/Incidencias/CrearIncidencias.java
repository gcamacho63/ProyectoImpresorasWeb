package controller.Incidencias;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Inicio.Login;
import model.Area;
import model.ConexionDB;
import model.Impresora;
import model.Incidencia;
import model.ModeloImpresora;
import model.Modulo;
import model.Tipificacion;
import model.Usuario;

/**
 * Servlet implementation class CrearIncidencias
 */
@WebServlet("/CrearIncidencias")
public class CrearIncidencias extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private String tabla="inc_incidencias";
	private String campoId="id_incidencias";
	private String carpeta=Login.Encripta("client_incidencias");
	private String archivo=Login.Encripta("crear_incidencias.jsp");
	private String pagina="index.jsp?sec="+carpeta+"&mod="+archivo+"";
	private String mensaje = "";
	private String tipoMensaje = "";
	private String alerta="";
		
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		HttpSession sesion = request.getSession();
		
		Usuario user = (Usuario)sesion.getAttribute("userLog");
		
		//Campos recibidos del formulario
		String impresora = request.getParameter("impresora");
		String tipificacion= request.getParameter("tipificacion");
		String prioridad = request.getParameter("prioridad");
		String descripcion = request.getParameter("descripcion");
		int idArea;
		//------------------------
		
		String action = request.getParameter("accion");
		
		ConexionDB.conectarDB();
		Object[][] temp = ConexionDB.Consulta("area", "imp_impresoras", "id_impresora= '"+impresora+"'");
		if(temp!=null)
		{
			idArea=(int)temp[0][0];
		}
		else
		{
			idArea=0;
		}
		String mensaje="";
		String tipoMensaje="";	
		if(action!=null)
		{
			if(action.equals("crear"))
			{		
				Incidencia [] validacion =Incidencia.Consultar("usuario_solicitante= '"+user.getId_usuario()+"' AND estadoActual != '30' AND tipificacion ='"+tipificacion+"' AND inc.id_impresora='"+impresora+"'"); 
				if(validacion==null)
				{
					Date fechaActu = new Date();
					
					Date fechaActual=sumarRestarHorasFecha(fechaActu,24);
					Timestamp fecha_maxima = new Timestamp(fechaActual.getTime());
					String campos="id_impresora,usuario_solicitante,usuario_encargado,tipificacion,anio,mes,fecha_maxima,area,prioridad,descripcion";
					String cadena="'"+impresora+"','"+user.getId_usuario()+"','2','"+tipificacion+"',YEAR(NOW()),MONTH (NOW()),'"+fecha_maxima+"','"+idArea+"','"+prioridad+"','"+descripcion+"'";								
					if(ConexionDB.Insert(tabla, campos,cadena))
					{
						Object[][] ultimo =ConexionDB.Consulta("MAX(id_incidencias)", "inc_incidencias", "1");
						ConexionDB.Insert("inc_estados_incidencias", "incidencia,estado,comentario", "'"+ultimo[0][0]+"','1','Incidencia registrada'");
						mensaje="Se ha registrado la incidencia con el numero de Ticket "+ultimo[0][0];
						tipoMensaje="success";
					}
					else
					{
						mensaje="Error en la operacion";
						tipoMensaje="danger";
					}	
				}
				else
				{
					Incidencia inc1=validacion[0];
					mensaje="Ya tiene una incidencia activa con estas caracteristicas con el numero de Ticket "+inc1.getId_incidencia();
					tipoMensaje="danger";
				}					
			}				
		}	
		else
		{
			mensaje="Accion no completada";
			tipoMensaje="danger";
		}
		request.getSession().setAttribute("mensaje", mensaje);
		request.getSession().setAttribute("tipoMensaje", tipoMensaje);
		response.sendRedirect(pagina);
	}			
	//Metodo que inicializa el listado de objetos para el JSP
	public static void inicializaListado(HttpServletRequest request)
	{
		HttpSession sesion = request.getSession();
		Usuario user = (Usuario)sesion.getAttribute("userLog");
		int idUser=user.getId_usuario();
		Incidencia[] listadoDeObjetos= Incidencia.Consultar("usuario_solicitante = '"+idUser+"'");
		if(listadoDeObjetos!=null)
		{
			sesion.setAttribute("listadoDeObjetos", listadoDeObjetos);
		}
	}
	public static void preparaPagina(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HttpSession sesion = request.getSession();
		Tipificacion[] tipificaciones= Tipificacion.ConsultarTipificaciones("estado = '0' ORDER BY nombre_tipificacion");
		sesion.setAttribute("tipificaciones", tipificaciones);
		Usuario user = (Usuario)sesion.getAttribute("userLog");
		int idUser=user.getId_usuario();
		int rol = user.getRol();
		String joinAdd;
		String clausula;
		if(rol!=3)
		{
			joinAdd="";
			clausula="imp.estado='0' ORDER BY nombre_area";
		}
		else
		{
			joinAdd="RIGHT JOIN user_impresoras_usuarios impuser ON impuser.impresora = imp.id_impresora ";
			clausula="impuser.usuario = '"+idUser+"' AND imp.estado = '0' ORDER BY nombre_area";
		}
		Impresora[] impresoras=Impresora.Consultar(clausula,joinAdd);
		sesion.setAttribute("impresoras", impresoras);
		inicializaListado(request);
	}
	public Date sumarRestarHorasFecha(Date fecha, int horas)
	{
	    Calendar calendar = Calendar.getInstance();
	    
	    calendar.setTime(fecha); // Configuramos la fecha que se recibe
	    	    
	    int horasSumar=0;
	    int horaMinima=7;
	    int horaMaxima=17;
	    int horasAtencion=6;
	    int hora;
	    
	    //calendar.set(2016, 8, 23,8, 10); pruebas
	    hora  =calendar.get(Calendar.HOUR_OF_DAY);
	    if(hora<horaMinima)
	    {
	    	horasSumar=horaMinima-hora;
	    	horasSumar=horasSumar+horasAtencion;
	    }
	    else if(hora>horaMaxima)
	    {
	    	horasSumar=24-hora;
	    	horasSumar=horasSumar+horaMinima+horasAtencion;
	    }
	    else if((hora+horasAtencion)>horaMaxima)
	    {
	    	horasSumar=horaMaxima-hora;
	    	int ant=horasSumar;
	    	horasSumar=horasSumar+(24-horaMaxima);
	    	horasSumar+=horaMinima+(horasAtencion-ant);
	    }
	    else
	    {
	    	horasSumar=horasAtencion;
	    }
	    calendar.add(Calendar.HOUR, horasSumar);  // numero de horas a añadir, o restar en caso de horas<0
	    	    
	    return calendar.getTime(); // Devuelve el objeto Date con las nuevas horas añadidas	
	 }
}