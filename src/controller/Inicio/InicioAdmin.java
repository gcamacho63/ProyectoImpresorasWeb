package controller.Inicio;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Incidencia;
import model.Usuario;

/**
 * Servlet implementation class InicioAdmin
 */
@WebServlet("/InicioAdmin")
public class InicioAdmin extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
	}
	
	public static void preparaPagina(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HttpSession sesion = request.getSession();
		Usuario userLog =(Usuario) sesion.getAttribute("userLog");
		int rol=userLog.getRol();
		int id=userLog.getId_usuario();
		if(rol!=3)
		{
			Date fechaActu = new Date();//Sacamos la fecha y  hora actual
			Timestamp fecha = new Timestamp(fechaActu.getTime());//La paseamos a TimeStamp
			
			Calendar calendar = Calendar.getInstance();//Creamos un objeto Calendar
			calendar.setTime(fechaActu);//Le asignamos la fecha actual
			calendar.set(Calendar.HOUR, calendar.get(Calendar.HOUR)+ 1);//Le sumamos una hora para las proximas a vencer 
			Date fechaTemp = calendar.getTime();
			Timestamp fechaMas = new Timestamp(fechaTemp.getTime());//Lo parseamos como FechaMas
			
			Incidencia[] incVencidas = Incidencia.Consultar("fecha_maxima < '"+fecha+"' AND estadoActual='1'");
			Incidencia[] incPorVencer = Incidencia.Consultar("fecha_maxima > '"+fecha+"' AND fecha_maxima < '"+fechaMas+"' AND estadoActual='1'");
			Incidencia[] incRegistradas = Incidencia.Consultar("estadoActual='1' AND fecha_maxima > '"+fecha+"' AND !(fecha_maxima > '"+fecha+"' AND fecha_maxima < '"+fechaMas+"')");		
			Incidencia[] incActivas = Incidencia.Consultar("estadoActual!='30' AND estadoActual !='1'");
			sesion.setAttribute("incVencidas", incVencidas);
			sesion.setAttribute("incPorVencer", incPorVencer );
			sesion.setAttribute("incRegistradas", incRegistradas);
			sesion.setAttribute("incActivas", incActivas);
		}
		else
		{
			Incidencia[] incActivas = Incidencia.Consultar("usuario_solicitante='"+id+"' AND estadoActual !='30'");
			sesion.setAttribute("incActivas", incActivas);
		}	
	}
}