from flask import Blueprint, request, jsonify

questions_blueprint = Blueprint('questions_blueprint', __name__)

from app import db_connection

@questions_blueprint.route('/questions-mc')
def get_questions_mc():
   cur = db_connection.get_db().cursor()
   cur.execute('select QuestionText as label, Questions.QuestionId as value from Questions join MCQuestions on Questions.QuestionId = MCQuestions.MCQuestionId')
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)

@questions_blueprint.route('/questions-sa')
def get_questions_sa():
   cur = db_connection.get_db().cursor()
   cur.execute('select QuestionText as label, Questions.QuestionId as value from Questions join ShortAnswerQuestions on Questions.QuestionId = ShortAnswerQuestions.ShortAnswerId')
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)

@questions_blueprint.route('/questions-mc-options')
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