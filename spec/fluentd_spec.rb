require 'rspec'
require 'yaml'
require 'bosh/template/test'

describe 'fluentd job' do

  let(:release_dir) { File.join(File.dirname(__FILE__), '..') }
  let(:release) { Bosh::Template::Test::ReleaseDir.new(release_dir) }
  let(:job) { release.job('fluentd') }

  describe 'bpm.yml' do
    let(:template) {job.template('config/bpm.yml')}

    it 'defaults to using --no-supervisor' do
        process = YAML::load(template.render({}))['processes'][0]
        expect(process['args']).to match(['--no-supervisor'])
    end

    it 'users user-defined args when supplied' do
        args = ['--foo', 'bar']
        process = YAML::load(template.render({'command_line_args' => args}))['processes'][0]
        expect(process['args']).to match(['--foo', 'bar'])
    end
  end

  describe 'ca.crt' do
    let(:template) {job.template('certs/ca.crt')}

    it 'has correctly processed the ca certificate template' do
      expected = "helloworld"

      properties = {
        'cert' => {
          'ca' => "helloworld"
        }
      }

      actual = template.render(properties)
      expect(actual).to match(expected)
    end

    it 'has correctly processed with no properties' do
        expected = ""

        actual = template.render({})
        expect(actual).to match(expected)
    end
  end

  describe 'cert.crt' do
    let(:template) {job.template('certs/cert.crt')}

    it 'has correctly processed the ca certificate template' do
      expected = "helloworld"

      properties = {
        'cert' => {
          'crt' => "helloworld"
        }
      }

      actual = template.render(properties)
      expect(actual).to match(expected)
    end

    it 'has correctly processed with no properties' do
        expected = ""

        actual = template.render({})
        expect(actual).to match(expected)
    end
  end

  describe 'cert.key' do
    let(:template) {job.template('certs/cert.key')}

    it 'has correctly processed the ca certificate template' do
      expected = "helloworld"

      properties = {
        'cert' => {
          'key' => "helloworld"
        }
      }

      actual = template.render(properties)
      expect(actual).to match(expected)
    end

    it 'has correctly processed with no properties' do
        expected = ""

        actual = template.render({})
        expect(actual).to match(expected)
    end
  end
end
