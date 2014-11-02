require 'spec_helper'

require 'github_connection'
require 'github_connection/octokit'

describe GithubConnection::Octokit do
  let(:username) { 'dwhenry' }
  subject { described_class.new(username) }

  it 'can require a list of repositories for a given user' do
    VCR.use_cassette('octokit_repos') do
      expect(subject.repositories.map(&:name)).to eq ["angular-lightbox",
        "base_sinatra_app",
        "bre-de",
        "brisruby_cplusplus",
        "db_manager",
        "devise",
        "factory-toys",
        "factory_girl",
        "fighter",
        "gsl",
        "ingenia_ruby",
        "kaos",
        "koc",
        "leap-fighter",
        "level1",
        "Markdown",
        "Pillow",
        "play",
        "play_iphone",
        "pointer",
        "poker",
        "rabbit-mq-consumers",
        "raffle",
        "responsible",
        "robot_tournament_setup",
        "rrtf2html",
        "rtf2html",
        "Rugby",
        "RxJSKoans",
        "security_workshop",
        "swarm",
        "trucks",
        "trucks_2",
        "WebSheet",
        "Websocket-Bomberman",
        "wedding-guest",
        "wedding_guest_iphone",
        "wherever",
        "wizardz",
        "workflow"
      ]
    end
  end
end
