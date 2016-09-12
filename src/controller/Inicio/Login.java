package controller.Inicio;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.ConexionDB;
import model.Modulo;
import model.ModulosGrupos;
import model.Usuario;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession sesion = request.getSession();
        
        if(ConexionDB.conectarDB())
        {
        	String user=request.getParameter("txtUser");
            String password=request.getParameter("txtPassword");
            try
            {           
                Usuario userLog=ConexionDB.Ingreso(user,password);
                if(userLog!=null)
                {  
                    sesion.setAttribute("userLog", userLog);
                    sesion.setMaxInactiveInterval(1200);
                    response.sendRedirect("index.jsp");                  
                }
                else
                {
                    sesion.setAttribute("errorInicio", "Usuario y/o Contraseña incorrectas");
                    response.sendRedirect("index.jsp");
                }
            }
            catch(NullPointerException e)
            {
                sesion.setAttribute("errorInicio", "Error al iniciar sesion");
                response.sendRedirect("index.jsp");
            }                                                       
        }
        else
        {
            sesion.setAttribute("errorInicio", "No se ha establecido la conexion con la  base de datos");
            response.sendRedirect("index.jsp");
        } 
	}
	public static void inicializaMenu(HttpServletRequest request)
	{
		Encripta("");
		ConexionDB.conectarDB();
		HttpSession sesion = request.getSession();
		sesion.removeAttribute("modulos");
		sesion.removeAttribute("grupos");
		Usuario user= (Usuario)sesion.getAttribute("userLog");
		int idRol= user.getRol();
		Modulo[] modulos =ConexionDB.MenuModulos(idRol);
        sesion.setAttribute("modulos", modulos);
        if(modulos!=null)
        {
        	ModulosGrupos[] grupos=ConexionDB.MenuGrupos(modulos);
            sesion.setAttribute("grupos", grupos);
        }
	}
	public static boolean validaPermisos(String modulo,HttpServletRequest request)
	{
		Usuario user=(Usuario) request.getSession().getAttribute("userLog");
		int idRol=user.getRol();
		ConexionDB.conectarDB();
		Object mod[][]=ConexionDB.Consulta("id_modulo", "gen_modulos", "archivo='"+modulo+"'");
		if(mod==null)
		{
			return false;
		}
		int identModulo = (int)mod[0][0];
		if(ConexionDB.Consulta("*", "gen_modulos_permisos", "id_rol='"+idRol+"' AND id_modulo='"+identModulo+"'")!=null)
		{
			return true;
		}
		else
		{
			return false;
		}	
	}
	public static void iniciaUserLog(HttpServletRequest request)
	{
		HttpSession sesion = request.getSession();
		Usuario user=(Usuario)sesion.getAttribute("userLog");
		Usuario[] arrayUser=null;
		arrayUser=Usuario.Consultar("id_usuario='"+user.getId_usuario()+"'");
		user=arrayUser[0];
		if(user.getEstado()==1)
		{
			sesion.removeAttribute("userLog");
		}
		else
		{
			sesion.setAttribute("userLog", user);
		}			
	}
	public static String Encripta(String mensaje)
	{ 
        char array[]=mensaje.toCharArray(); 
         
        for(int i=0;i<array.length;i++)
        { 
            array[i]=(char)(array[i]+(char)5); 
        } 
        String encriptado =String.valueOf(array); 
		return  encriptado;
	}
	public static String Desencripta(String encriptado)
	{
		char arrayD[]=encriptado.toCharArray(); 
        for(int i=0;i<arrayD.length;i++)
        { 
            arrayD[i]=(char)(arrayD[i]-(char)5); 
        } 
        String desencriptado =String.valueOf(arrayD); 
        return desencriptado;
	}
}