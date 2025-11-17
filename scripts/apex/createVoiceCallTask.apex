// One-off Apex script to create a standard Task record representing a voice call.
// Usage: sf apex run --file scripts/apex/createVoiceCallTask.apex -o <targetOrgAlias>
//
// Notes:
// - Adjust the sample WhoId/WhatId to valid IDs in your org before running,
//   or leave them null if not applicable.
// - Standard Task fields used:
//   Subject (e.g., "Call: Follow up"),
//   Type ("Call"),
//   CallDisposition (result of call),
//   CallDurationInSeconds (numeric),
//   CallType (Inbound/Outbound),
//   Status ("Completed" or "Not Started"),
//   Priority, ActivityDate, WhoId (Lead/Contact), WhatId (Account/Opportunity/Case), Description.
//
// This script uses placeholder IDs and values for safety. Replace as needed.

Id contactId; // = '003XXXXXXXXXXXX'; // Optional: set to an existing Contact Id
Id whatId;    // = '001XXXXXXXXXXXX'; // Optional: set to an existing Account/Opportunity/Case Id

String subject                = 'Call: Intro and Discovery';
String callDisposition        = 'Left Voicemail';    // Set to your org’s picklist value if restricted
Integer callDurationSeconds   = 180;                 // 3 minutes
String callType               = 'Outbound';          // 'Inbound' or 'Outbound'
String status                 = 'Completed';         // Common values: 'Completed', 'Not Started'
String priority               = 'Normal';            // 'High', 'Normal', 'Low'
Date activityDate             = Date.today();
String description            = 'Logged via script for demo. Spoke about product fit and next steps.';

Task t = new Task();
t.Subject                   = subject;
t.Type                      = 'Call';
t.Status                    = status;
t.Priority                  = priority;
t.ActivityDate              = activityDate;
t.Description               = description;

// Optional relationships
if (contactId != null) t.WhoId = contactId;
if (whatId != null)    t.WhatId = whatId;

// Call-specific fields
t.CallDisposition          = callDisposition;
t.CallDurationInSeconds    = callDurationSeconds;
t.CallType                 = callType;

insert t;
System.debug('Created Voice Call Task Id: ' + t.Id);
