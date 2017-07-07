

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectMustache




class Handlers  {
    private let index = "/"
    private let developers = "/developers"
    private let regist = "/registration"
    
    
    struct mustacheHelper: MustachePageHandler {
        var values:  MustacheEvaluationContext.MapType
        func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
            contxt.extendValues(with: values)
            do {
                try contxt.requestCompleted(withCollector: collector)
            } catch {
                let response = contxt.webResponse
                response.appendBody(string: "\(error)")
                response.completed()
            }
        }
    }
    
    func index(request: HTTPRequest, response: HTTPResponse) {
        var values = MustacheEvaluationContext.MapType()
        values["title"]="Главная страница"
        values["regist"] = regist
        values["index"] = index
        values["developers"] = developers
        mustacheRequest(request: request, response: response, handler: mustacheHelper(values: values),
                        templatePath:"\(request.documentRoot)/index.html")
    }
    func developers(request: HTTPRequest, response: HTTPResponse) {
        var values = MustacheEvaluationContext.MapType()
        values["title"]="О разработчиках"
        values["regist"] = regist
        values["index"] = index
        values["developers"] = developers
        mustacheRequest(request: request, response: response, handler: mustacheHelper(values: values),
                        templatePath:"\(request.documentRoot)/developers.html")
    }
    func registration(request: HTTPRequest, response: HTTPResponse) {
        var values = MustacheEvaluationContext.MapType()
        values["title"]="Регистрация"
        values["regist"] = regist
        values["index"] = index
        values["developers"] = developers
        mustacheRequest(request: request, response: response, handler: mustacheHelper(values: values),
                        templatePath:"\(request.documentRoot)/registration.html")
    }
    
}
//////////////swift build
//.build/debug/perfect-server
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

let handlers = Handlers()
let server = HTTPServer()
var routes = Routes()
server.serverPort = 8181
server.documentRoot="webroot"

routes.add(method: .get, uri:"/", handler: handlers.index)
routes.add(method: .get, uri:"/index", handler: handlers.index)
routes.add(method: .get, uri:"/developers", handler: handlers.developers)
routes.add(method: .get, uri:"/registration", handler: handlers.registration)
server.addRoutes(routes)
do {
    try server.start()
}catch {
    fatalError("\(error)")
}

