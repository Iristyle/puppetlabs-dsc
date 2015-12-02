#! /usr/bin/env ruby
require 'spec_helper'
require 'puppet/type'
require 'puppet_x/puppetlabs/dsc_type_helpers'
# require_relative '../../../fixtures/modules/reboot/lib/puppet'

describe PuppetX::Dsc::TypeHelpers, :if => Puppet::Util::Platform.windows? do
  def compile_to_catalog(string, node = Puppet::Node.new('foonode'))
    Puppet[:code] = string
    # see lib/puppet/indirector/catalog/compiler.rb#filter
    Puppet::Parser::Compiler.compile(node).filter { |r| r.virtual? }
  end

  def compile_to_ral(manifest)
    catalog = compile_to_catalog(manifest)
    ral = catalog.to_ral
    ral.finalize
    ral
  end

  def compile_to_relationship_graph(manifest, prioritizer = Puppet::Graph::SequentialPrioritizer.new)
    ral = compile_to_ral(manifest)
    graph = Puppet::Graph::RelationshipGraph.new(prioritizer)
    graph.populate_from(ral)
    graph
  end

  def catalog_to_relationship_graph(catalog, prioritizer = Puppet::Graph::SequentialPrioritizer.new)
    ral = catalog.to_ral
    ral.finalize
    graph = Puppet::Graph::RelationshipGraph.new(prioritizer)
    graph.populate_from(ral)
    graph
  end

  context ".ensure_reboot_relationship" do
    it "should work" do
      # this seems to work when running
      # Puppet[:modulepath] += ';' + File.join(File.dirname(__FILE__), '..', '..', '..', 'fixtures', 'modules')

      # relationship_graph = compile_to_relationship_graph(<<-MANIFEST)
      #   reboot { 'dsc_reboot':
      #     when => pending,
      #   }

      #   dsc_file {'foo':
      #     dsc_destinationpath => 'c:\\foo.txt',
      #     dsc_contents => 'foo'
      #   }
      # MANIFEST

      # require 'pry'; binding.pry
    end
    # audit only resources are unmanaged
    # as are resources without properties with should values

    it "should create appropriate relationship graph edges" do

      # before do
      #   # stub this to not try to create state.yaml
        Puppet::Util::Storage.stubs(:store)
      # end

      # TODO: theoretically this should be simpler, however, having problems loading code for reboot module correctly
      require_relative '../../../fixtures/modules/reboot/lib/puppet/type/reboot'

      require 'pry'; binding.pry
      catalog = Puppet::Resource::Catalog.new('my_node')

      # resourcefile = tmpfile('resourcefile')
      # Puppet[:resourcefile] = resourcefile

      dsc_file = Puppet::Type.type('dsc_file').new(:title => 'foo', :dsc_destinationpath => 'c:\\foo.txt', :dsc_contents => 'foo')
      reboot = Puppet::Type.type('reboot').new(:title => 'dsc_reboot', :when => 'pending')
      # comp_res = Puppet::Type.type('component').new(:title => 'Class[Main]')

      catalog.add_resource(dsc_file, reboot)
      relationship_graph = catalog_to_relationship_graph(catalog)

      relationship_graph.edge?(dsc_file, reboot).should be_true
    end
  end
end
