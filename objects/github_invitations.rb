# Copyright (c) 2016-2018 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

#
# Invitations in Github
#
class GithubInvitations
  def initialize(github)
    @github = github
  end

  def accept
    @github.user_repository_invitations.each do |i|
      if @github.accept_repository_invitation(i['id'])
        puts "Repository invitation #{i['id']} accepted"
      end
    end
  end

  def accept_orgs
    @github.organization_memberships('state' => 'pending').each do |m|
      @github.update_organization_membership(
        m['organization']['login'],
        'state' => 'active'
      )
      puts "Invitation for organization #{m['organization']['login']} accepted"
    end
  end
end
