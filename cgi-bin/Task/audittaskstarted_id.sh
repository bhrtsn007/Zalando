#!/bin/bash
audit_task_started () {
    echo "All Audit task on PPS which is in started"
    echo "<br>"
    if [ "$2" -eq "1" ]; then
      echo '<pre>'
       sudo /opt/butler_server/erts-9.3/bin/escript /home/gor/rpc_call.escript audittaskrec search_by "[[{'pps_id', 'equal',$1},{'status', 'equal', {'pending','started'}}], 'key']."
       echo '</pre>'
    elif [ "$2" -eq "2" ]; then
      echo '<pre>'
       sudo /opt/butler_server/erts-9.3/bin/escript /home/gor/rpc_call.escript audittaskrec search_by "[[{'pps_id', 'equal',$1},{'status', 'equal', {'pending','started'}}], 'record']."
       echo '</pre>'
    else 
        echo "Wrong Key pressed"
    fi
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Specific audit Task on PPS for status started</title>'
echo '</head>'
echo '<body style="background-color:#B8B8B8">'

echo '<img src="https://scmtech.in/assets/images/grey.png" style="position:fixed; TOP:5px; LEFT:850px; WIDTH:400px; HEIGHT:80px;"></img>'
echo "<br>"
echo "<br>"
echo "<br>"
echo "<br>"
echo "<br>"
echo "<br>"

  echo "<form method=GET action=\"${SCRIPT}\">"\
       '<table nowrap>'\
          '<tr><td>PPS_ID</TD><TD><input type="number" name="PPS_ID" size=12></td></tr>'\
		  '<tr><td>Type 1 for key and 2 for record</TD><TD><input type="number" name="Type 1 for key and 2 for record" size=12></td></tr>'\
		  '</tr></table>'

  echo '<br><input type="submit" value="SUBMIT">'\
       '<input type="reset" value="Reset"></form>'

  # Make sure we have been invoked properly.

  if [ "$REQUEST_METHOD" != "GET" ]; then
        echo "<hr>Script Error:"\
             "<br>Usage error, cannot complete request, REQUEST_METHOD!=GET."\
             "<br>Check your FORM declaration and be sure to use METHOD=\"GET\".<hr>"
        exit 1
  fi

  # If no search arguments, exit gracefully now.
  echo "$QUERY_STRING<br>"
  echo "<br>"
  if [ -z "$QUERY_STRING" ]; then
        exit 0
  else
   # No looping this time, just extract the data you are looking for with sed:
     XX=`echo "$QUERY_STRING" | sed -r 's/([^0-9]*([0-9]*)){1}.*/\2/'`
	   YY=`echo "$QUERY_STRING" | sed -n 's/^.*record=\([^ ]*\).*$/\1/p'`
	
     echo "PPS_ID: " $XX
     echo '<br>'
	   echo "Type 1 for key and 2 for record: " $YY
     echo '<br>'
     audit_task_started $XX $YY

 #audit task started $XX $YY
     
  fi
echo '</body>'
echo '</html>'

exit 0