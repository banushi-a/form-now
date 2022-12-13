from flask import Blueprint, request, jsonify

respondents_blueprint = Blueprint('respondents_blueprint', __name__)

from app import db_connection

@respondents_blueprint.route('/respondents')
def get_respondents():
   cur = db_connection.get_db().cursor()
   cur.execute('select FirstName as label, RespondentUsername as value from Respondents')
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)


@respondents_blueprint.route('/respondent-forms')
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

@respondents_blueprint.route('/respondent-num-forms')
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

@respondents_blueprint.route('/respondent-num-questions')
def get_respondent_num_questions():
  creator = request.args.get('respondent-id')
  cur = db_connection.get_db().cursor()
  cur.execute("select count(*) as count from FormsRespondentsQuestions where RespondentUsername = '" + str(creator) +"'")
  row_headers = [x[0] for x in cur.description]
  json_data = []
  theData = cur.fetchall()
  for row in theData:
      json_data.append(dict(zip(row_headers, row)))
  return jsonify(json_data)

@respondents_blueprint.route('/respondent-num-correct-mc-questions')
def get_respondent_num_correct_mc_questions():
  creator = request.args.get('respondent-id')
  cur = db_connection.get_db().cursor()
  cur.execute("""select count(*) as num from FormsRespondentsQuestions
                                 natural join Questions
                                 join MCQuestions on MCQuestionId = Questions.QuestionId
                                 natural join MCQuestionPossibilities where MCQuestionCorrect = 1 and MCQuestionPossibilityText = Answer and RespondentUsername = '""" + str(creator) +"'")
  row_headers = [x[0] for x in cur.description]
  json_data = []
  theData = cur.fetchall()
  for row in theData:
      json_data.append(dict(zip(row_headers, row)))
  return jsonify(json_data)

@respondents_blueprint.route('/respondent-num-wrong-mc-questions')
def get_respondent_num_wrong_mc_questions():
  creator = request.args.get('respondent-id')
  cur = db_connection.get_db().cursor()
  cur.execute("""select count(*) as num from FormsRespondentsQuestions
                                 natural join Questions
                                 join MCQuestions on MCQuestionId = Questions.QuestionId
                                 natural join MCQuestionPossibilities where MCQuestionCorrect = 0 and MCQuestionPossibilityText = Answer and RespondentUsername = '""" + str(creator) +"'")
  row_headers = [x[0] for x in cur.description]
  json_data = []
  theData = cur.fetchall()
  for row in theData:
      json_data.append(dict(zip(row_headers, row)))
  return jsonify(json_data)


