require 'yaml'
require 'erb'

def generate_latex(yaml_file, template_file, output_file)
    # Load data from YAML file
    yaml_data = YAML.load_file(yaml_file)

    # Load ERB template
    template = File.read(template_file)
    erb = ERB.new(template)

    binding_obj = binding()

    sidebar_data = yaml_data['sidebar']
    binding_obj.local_variable_set(:name, sidebar_data['name'])
    binding_obj.local_variable_set(:email, sidebar_data['email'])
    binding_obj.local_variable_set(:avatar, sidebar_data['avatar'])

    # Summary
    binding_obj.local_variable_set(:career_summary, yaml_data['career-profile']['summary'])

    # Experience
    experiences_data = yaml_data['experiences']
    binding_obj.local_variable_set(:experiences_title, experiences_data['title'])
    binding_obj.local_variable_set(:experiences_data, experiences_data['info'])

    # Education
    education_data = yaml_data['education']
    binding_obj.local_variable_set(:education_title, education_data['title'])
    binding_obj.local_variable_set(:education_data, education_data['info'])

    # Languages
    binding_obj.local_variable_set(:languages_data, sidebar_data['languages']['info'])


    # Render the template with YAML data
    latex_content = erb.result(binding_obj)

    # Write generated LaTeX content to output file
    File.write(output_file, latex_content)
end

generate_latex('../_data/data.yml', 'cv-template.erb', 'output.tex')
