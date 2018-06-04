# ansible-awslogs_config #

Generic role for configuring log streaming to CloudWatch Logs.

## Requirements ##

Ansible 2.0.

## Role Variables ##

     - name: awslogs_config_name
       desc: name of the configuration file

     - name: awslogs_config_settings
       desc: list of log configuration settings to be placed into a single config file:

         - name: group_name
           desc: Specifies destination log group. A log group will be created automatically if it doesn't already exist.

         - name: stream_name
           desc: Specifies destination log stream (optional). You can use a literal string or predefined variables ({instance_id}, {hostname}, {ip_address}), or combination of both to define a log stream name. A log stream will be created automatically if it doesn't already exist.
           default: {hostname}

         - name: datetime_format
           desc: Specifies how the timestamp is extracted from logs. The timestamp is used for retrieving log events and generating metrics. The current time is used for each log event if the datetime_format isn't provided. If the provided datetime_format is invalid for a given log message, the timestamp from the last log event with a successfully parsed timestamp will be used. If no previous log events exist, the current time is used.

         - name: time_zone
           desc: Specifies the time zone of log event timestamp (optional). The two supported values are UTC and LOCAL. The default is LOCAL, which is used if time zone can't be inferred based on datetime_format.

         - name: file
           desc: Absolute path to log files that you want to push to CloudWatch Logs.

         - name: file_fingerprint_lines
	   desc: Specifies the range of lines for identifying a file (optional). The valid values are one number or two dash delimited numbers, such as '1', '2-5'. The default value is '1' so the first line is used to calculate fingerprint. Fingerprint lines are not sent to CloudWatch Logs unless all the specified lines are available.

         - name: multi_line_start_pattern
           desc: Specifies the pattern for identifying the start of a log message (optional). A log message is made of a line that matches the pattern and any following lines that don't match the pattern. The valid values are regular expression or {datetime_format}. When using {datetime_format}, the datetime_format option should be specified. The default value is '^[^\s]' so any line that begins with non-whitespace character closes the previous log message and starts a new log message.

         - name: initial_position
           desc: Specifies where to start to read data (start_of_file or end_of_file) (optional). The default is start_of_file. It's only used if there is no state persisted for that log stream.

         - name: encoding
           desc: Specifies the encoding of the log file so that the file can be read correctly (optional). The default is utf_8. Encodings supported by Python codecs.decode() can be used here.

         - name: buffer_duration
           desc: Specifies the time duration for the batching of log events (optional). The minimum value is 5000ms and default value is 5000ms.

         - name: batch_count
           desc: Specifies the max number of log events in a batch, up to 10000 (optional). The default value is 1000.

         - name: batch_size
           desc: Specifies the max size of log events in a batch, in bytes, up to 1048576 bytes (optional). The default value is 32768 bytes. This size is calculated as the sum of all event messages in UTF-8, plus 26 bytes for each log event.

## Dependencies ##

- shared/awslogs

## Example Playbook ##
----------------

    - hosts: servers
      roles:
        - role: shared/awslogs_config
          awslogs_config_name: tv
          awslogs_config_settings:
            - file: "/var/traveloka/log/tv.log"
              datetime_format: "%Y/%m/%d %H:%M:%S.%f"
              group_name: "tv.log"
            - file: "/var/traveloka/log/tv.rpc.client.log"
              datetime_format: "%Y/%m/%d %H:%M:%S.%f"
              group_name: "tv.rpc.client.log"
            - file: "/var/traveloka/log/tv.rpc.server.log"
              datetime_format: "%Y/%m/%d %H:%M:%S.%f"
              group_name: "tv.rpc.server.log"
