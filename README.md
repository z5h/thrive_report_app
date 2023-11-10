# ThriveTakehome

This is a Ruby gem that provides a command line interface for the Thrive Takehome project.

Bundler can be used to install the gem, run or test.

Alternatively, the application can be directly run, with no setup, by executing: 

    ./challenge.rb

from the root directory of the project.

With no parameters supplied, the help screen will be displayed.

    Commands:
        challenge.rb report COMPANY_FILE_PATH USER_FILE_PATH   # Run a Top Up Report for a given company and user file
        challenge.rb version                                   # Print version

To run the report with the sample data provided, execute:

    ./challenge.rb report test/fixtures/companies.json test/fixtures/users.json

# Output Format

The provided sample output uses a mix of tab characters and spaces for indentation.
The sample output also made inconsistent use of commas.
These inconsistencies were preserved in the interest of matching the sample output exactly. 