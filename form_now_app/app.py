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
from questions_api.questions import questions_blueprint
app.register_blueprint(questions_blueprint, url_prefix="")

@app.route('/respondent-response', methods=['POST'])
def post_response():
    app.logger.info(request.form)
    cursor = db_connection.get_db().cursor()
    respondentId = request.form['respondent-id']
    questionId = request.form['question-id']
    answer = request.form['answer']
    query = f'INSERT INTO FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) VALUES (\"{questionId}\", \"{respondentId}\", \"{answer}\")'
    cursor.execute(query)
    db_connection.get_db().commit()
    return "Didn't fail!"

@app.route('/creator-new-q', methods=['POST'])
def post_new_q():
    app.logger.info(request.form)
    cursor = db_connection.get_db().cursor()
    questionText = request.form['question-text']
    requiresResponse = request.form['requires-response']
    requiresResponse = 1 if requiresResponse else 0
    questionWeight = request.form['question-weight']
    query = f'INSERT INTO Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) VALUES (1, \"{questionText}\", \"{requiresResponse}\", \"{questionWeight}\")'
    cursor.execute(query)
    db_connection.get_db().commit()
    return "Didn't fail!"

# If this file is being run directly, then run the application 
# via the app object. 
# debug = True will provide helpful debugging information and 
#   allow hot reloading of the source code as you make edits and 
#   save the files. 
if __name__ == '__main__': 
    app.run(debug = True, host = '0.0.0.0', port = 4000)