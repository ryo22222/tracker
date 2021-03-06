require 'spec_helper'

describe Tracker::Api::Yuusei do
  let(:yuusei) { Tracker::Api::Yuusei.new no: "123412341231" }

  describe ".new" do
    context "initialize number" do
      subject { yuusei.no }
      it { should eq "123412341231" }
    end
  end

  describe "#execute" do
    context "データがある" do
      subject { yuusei.execute }
      it { expect(subject.data).not_to be_empty }
      it { expect(subject.details).not_to be_empty }
    end
  end

  describe "#build_param" do
    subject { yuusei.build_param }
    it { expect(subject.data).to include ["reqCodeNo1", "123412341231"] }
  end

  describe "#create_form" do
    subject { yuusei.build_param.create_form }
    it { expect(subject.uri).not_to be_empty }
    it { expect(subject.uri).to match "&reqCodeNo1=123412341231" }
  end

  describe "#make" do
    context "オリジナルデータをもっている" do
      subject { yuusei.execute.make.details[0]["origin"] }
      it { expect(subject).not_to be_empty }
    end
  end

  describe "#result" do
    context "Hash配列をかえす" do
      subject { yuusei.execute.make.result }
      it { should be_a Array }
      it { expect(subject[0]).to be_key "no" }
      it { expect(subject[0]).to be_value "123412341231" }
    end
  end

end
