from flask import Flask, jsonify, render_template, Blueprint
from flask_restx import Api, Resource, Swagger
from flask_restx.apidoc import apidoc

#apidoc.static_url_path = "/myapp/swaggerui"

@apidoc.add_app_template_global
def swagger_static(filename):
    return "/myapp/swaggerui/{0}".format(filename)

app = Flask(__name__)
api = Api(app, doc='/swagger')

@api.route('/custom-swagger.json')
class CustomSwaggerJson(Resource):
    def get(self):
        """Returns swagger.json with updated basePath"""
        swagger = Swagger(api)
        d = swagger.as_dict()
        d['basePath'] = '/myapp'
        return jsonify(d)

@api.documentation
def custom_ui():
    return render_template("swagger-ui.html", title=api.title, specs_url="/myapp/custom-swagger.json")

@api.route('/api/hello')
class HelloWorld(Resource):
    def get(self):
        """Returns a hello world message"""
        return jsonify({"message": "Hello, World!"})

if __name__ == '__main__':
    print(app.url_map)
    app.run(host='0.0.0.0', debug=True)
