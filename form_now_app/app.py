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
app.config['MYSQL_DATABASE_PASSWORD'] = 'abc123';
app.config['MYSQL_DATABASE_DB'] = 'form_now_db';

# create the MySQL object and connect it to the 
# Flask app object
db_connection = MySQL()
db_connection.init_app(app)

# Create a function named hello world that 
# returns a simple html string 
# the @app.route("/") connects the hello_world function to 
# the URL / 
@app.route("/")
def hello_world():
    return f'<h1>hullo wurld</h1>'

# Flask + SQL Magic Goes Here
@app.route('/db_test')
def db_testing():
   cur = db_connection.get_db().cursor()
   cur.execute('select * from Respondents')
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)


@app.route('/creators')
def get_creators():
   cur = db_connection.get_db().cursor()
   cur.execute('select Email as label, CreatorUsername as value from Creators')
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)

@app.route('/respondents')
def get_respondents():
   cur = db_connection.get_db().cursor()
   cur.execute('select FirstName as label, RespondentUsername as value from Respondents')
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)

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
    return "Success!"

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

@app.route('/creator-forms')
def get_creator_forms():
    creator = request.args.get('creator-id')
    cur = db_connection.get_db().cursor()
    cur.execute("select FormId as id, FormName as name from Forms where CreatorUsername = '" + str(creator) +"'")
    row_headers = [x[0] for x in cur.description]
    json_data = []
    theData = cur.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    return jsonify(json_data)

@app.route('/respondent-forms')
def get_respondent_forms():
    respondent = request.args.get('respondent-id')
    cur = db_connection.get_db().cursor()
    cur.execute("select FormId as id, FormName as name from Respondents natural join FormsRespondents natural join Forms where RespondentUsername = '" + str(respondent) +"'")
    row_headers = [x[0] for x in cur.description]
    json_data = []
    theData = cur.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    return jsonify(json_data)

@app.route('/creator-num-forms')
def get_creator_num_forms():
  creator = request.args.get('creator-id')
  cur = db_connection.get_db().cursor()
  cur.execute("select count(*) from Forms where CreatorUsername = '" + str(creator) +"'")
  row_headers = [x[0] for x in cur.description]
  json_data = []
  theData = cur.fetchall()
  for row in theData:
      json_data.append(dict(zip(row_headers, row)))
  return jsonify(json_data)

@app.route('/respondent-num-forms')
def get_respondent_num_forms():
  respondent = request.args.get('respondent-id')
  cur = db_connection.get_db().cursor()
  cur.execute("select count(*) as count from Respondents natural join FormsRespondents natural join Forms where RespondentUsername = '" + str(respondent) +"'")
  row_headers = [x[0] for x in cur.description]
  json_data = []
  theData = cur.fetchall()
  for row in theData:
      json_data.append(dict(zip(row_headers, row)))
  return jsonify(json_data)

@app.route('/creator-num-questions')
def get_creator_num_questions():
  creator = request.args.get('creator-id')
  cur = db_connection.get_db().cursor()
  cur.execute("select count(*) from Questions natural join Forms where CreatorUsername = '" + str(creator) +"'")
  row_headers = [x[0] for x in cur.description]
  json_data = []
  theData = cur.fetchall()
  for row in theData:
      json_data.append(dict(zip(row_headers, row)))
  return jsonify(json_data)

@app.route('/respondent-num-questions')
def get_respondent_num_questions():
  creator = request.args.get('respondent-id')
  cur = db_connection.get_db().cursor()
  cur.execute("select count(*) as count from Respondents natural join FormsRespondentsQuestions where RespondentUsername = '" + str(creator) +"'")
  row_headers = [x[0] for x in cur.description]
  json_data = []
  theData = cur.fetchall()
  for row in theData:
      json_data.append(dict(zip(row_headers, row)))
  return jsonify(json_data)

@app.route('/respondent-num-correct-mc-questions')
def get_respondent_num_correct_mc_questions():
  creator = request.args.get('respondent-id')
  cur = db_connection.get_db().cursor()
  cur.execute("""select count(*) as num from Respondents 
                                 natural join FormsRespondentsQuestions
                                 natural join Questions
                                 join MCQuestions on MCQuestionId = Questions.QuestionId
                                 natural join MCQuestionPossibilities where MCQuestionCorrect = 1 and RespondentUsername = '""" + str(creator) +"'")
  row_headers = [x[0] for x in cur.description]
  json_data = []
  theData = cur.fetchall()
  for row in theData:
      json_data.append(dict(zip(row_headers, row)))
  return jsonify(json_data)

@app.route('/respondent-num-wrong-mc-questions')
def get_respondent_num_wrong_mc_questions():
  creator = request.args.get('respondent-id')
  cur = db_connection.get_db().cursor()
  cur.execute("""select count(*) as num from Respondents 
                                 natural join FormsRespondentsQuestions
                                 natural join Questions
                                 join MCQuestions on Questions.QuestionId = MCQuestionId
                                 natural join MCQuestionPossibilities where MCQuestionCorrect = 0 and RespondentUsername = '""" + str(creator) +"'")
  row_headers = [x[0] for x in cur.description]
  json_data = []
  theData = cur.fetchall()
  for row in theData:
      json_data.append(dict(zip(row_headers, row)))
  return jsonify(json_data)

@app.route('/creator-total-weight')
def get_creator_sum_questions():
  creator = request.args.get('creator-id')
  cur = db_connection.get_db().cursor()
  cur.execute("select sum(QuestionWeight) as 'Total Question Weight' from Questions natural join Forms where CreatorUsername = '" + str(creator) +"'")
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