package WebLab.Servlets;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class ControllerServlet extends HttpServlet {
    /**
     * Сервлет определяющий тип запроса, и, в зависимости от того,
     * содержит ли запрос информацию о координатах точки и радиусе,
     * делегирующий его обработку соответствующему сервлету.
     * <p>
     * Все запросы внутри приложения должны передаваться этому сервлету,
     * остальные сервлеты с веб-страниц напрямую вызываться не должны.
     */

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        loadStartTime(request); //запись времени, когда началась обработка запроса
        RequestDispatcher requestDispatcher;

        if (paramsAreSet(request)) {
            /*  Если все параметры присутствуют в теле запроса, то обработка делегируется сервлету AreaCheckServlet.    */
            requestDispatcher = request.getRequestDispatcher("/AreaCheck");
        } else {
            /*  Если запрос пуст, обработка делегируется JSP странице.
             *  Причем запросы, содержацие не все поля формы, обрабатывается как пустые.
             */
            requestDispatcher = request.getRequestDispatcher("/index.jsp");
        }
        requestDispatcher.forward(request, response);
    }

    /**
     * Проверка на установленность всех значений
     * @param request - HTTP запрос (в данном сервлете обрабатываюся только POST запросы).
     * @return True, если все параметры присутствуют в теле запроса.
     */
    private boolean paramsAreSet(HttpServletRequest request) {
        String requestParameterX = request.getParameter("X");
        String requestParameterY = request.getParameter("Y");
        String requestParameterR = request.getParameter("R");
        return (requestParameterX != null) &&
                (requestParameterY != null) &&
                (requestParameterR != null);
    }

    private void loadStartTime(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.setAttribute("startTime", System.nanoTime());
    }
}

