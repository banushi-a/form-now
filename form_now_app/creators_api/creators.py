from flask import Blueprint, request, jsonify

creators_blueprint = Blueprint('creators_blueprint', __name__)

from app import db_connection

@creators_blueprint.route('/creators')
def get_creators():
   cur = db_connection.get_db().cursor()
   cur.execute('select Email as label, CreatorUsername as value from Creators')
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)

@creators_blueprint.route('/creator-forms')
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

@creators_blueprint.route('/creator-num-forms')
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

@creators_blueprint.route('/creator-num-questions')
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

@creators_blueprint.route('/creator-total-weight')
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