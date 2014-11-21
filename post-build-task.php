<?php

/**
 * This script sends build status info to Phabricator's Harbormaster.
 *
 * This script runs as a Post-Build task on Jenkins.
 * It needs the Jenkins job name passed  and Phabricator's PHID as command line
 * argument.
 *
 * Eg. php ~/post-build-task/index.php -j 'Jenkins-Build-Job-Id' -p $PHID
 * Note. You have to execute this a php commandline app
 */

/**
 * Send a request to JENKS last build API
 * @return string JSON string of the status of the build.
 */
function requestLastBuild() {

    // Get commandline arguments
    $options = getopt('j:p:');

    // Get the Job ID
    $jobname = $options['j'];

    // Get Phabricator's PHID of the current build target.
    $phid = $options['p'];

    // URL of jenkins last build
    $url = "http://jenkins-server/job/$jobname/lastBuild/api/json";

    // Make a request
    $curl = curl_init( $url );
    curl_setopt( $curl, CURLOPT_RETURNTRANSFER, 1 );
    curl_setopt($curl, CURLOPT_USERAGENT, "Mozilla/1.0");
    $ret = curl_exec( $curl );
    $result = json_decode( $ret );

    $message = ['buildTargetPHID' => $phid ];

    if($result->result === 'SUCCESS')
    {
        $message['type'] = 'pass';
    }
    else
    {
        $message['type'] = 'fail';
    }

    // Close connection
    curl_close($curl);

    return json_encode($message);

}

/**
 * Sends the build status info the Phabricator's Harbormaster
 */
function sendMessage() {

    $message = requestLastBuild();
    $message =  addslashes($message);
    $output = shell_exec("echo $message |arc call-conduit harbormaster.sendmessage");
    print $output;
}

// Execute instructions
sendMessage();
