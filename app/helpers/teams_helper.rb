module TeamsHelper

	def generate_teams

		unassigned_students = []

		Student.all.each do |student|

			unassigned_students.push(student.name)

		end

		num_teams = params[:num].to_i 

		# > 0 ? params[:num].to_i : 1

		team_size = unassigned_students.count / num_teams

		teams = [ ] 

		until teams.count == num_teams 

			teammates = unassigned_students.sample(team_size)

			teams.push(teammates)

			teammates.each do |student|
				unassigned_students.delete(student)
			end
		end

		if unassigned_students.count > 0
			teams[teams.length-1].push(unassigned_students)
		end

		return teams 
	end

	def save_teams 
	    Team.destroy_all
	    if @teams != nil 
		    @teams.each do |team|
		      Team.create(members: team.join(', '))
		    end
		end
	end
end



