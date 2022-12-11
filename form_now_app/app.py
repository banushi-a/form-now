# import the Flask framework
from multiprocessing import current_process
from flask import Flask, jsonify, request
from flaskext.mysql import MySQL

# create a flask object
app = Flask(__name__)

# --------------------------------------------------------------------
# add db config variables to the app object
app.config['MYSQL_DATABASE_HOST'] = 'db'
app.config['MYSQL_DATABASE_PORT'] = 3306
app.config['MYSQL_DATABASE_USER'] = 'webapp'
app.config['MYSQL_DATABASE_PASSWORD'] = 'abc123'
app.config['MYSQL_DATABASE_DB'] = 'form_now_db'

# create the MySQL object and connect it to the 
# Flask app object
db_connection = MySQL()
db_connection.init_app(app)

# register blueprints (in such a way to avoid circular imports :p)
from respondents_api.respondents import respondents_blueprint
app.register_blueprint(respondents_blueprint, url_prefix="")
from creators_api.creators import creators_blueprint
app.register_blueprint(creators_blueprint, url_prefix="")

@app.route('/questions-mc')
def get_questions_mc():
   cur = db_connection.get_db().cursor()
   cur.execute('select QuestionText as label, Questions.QuestionId as value from Questions join MCQuestions on Questions.QuestionId = MCQuestions.MCQuestionId')
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)

@app.route('/questions-mc-options')
def get_questions_mc_options():
   cur = db_connection.get_db().cursor()
   mcqID = request.args.get('mcq-id')
   cur.execute("select MCQuestionPossibilityText as label, MCQuestionPossibilityId as value from Questions join MCQuestions on Questions.QuestionId = MCQuestions.MCQuestionId natural join MCQuestionPossibilities where MCQuestions.MCQuestionId = '" + str(mcqID) +"'")
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)

# If this file is being run directly, then run the application 
# via the app object. 
# debug = True will provide helpful debugging information and 
#   allow hot reloading of the source code as you make edits and 
#   save the files. 
if __name__ == '__main__': 
    app.run(debug = True, host = '0.0.0.0', port = 4000)