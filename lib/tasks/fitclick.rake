namespace :fitclick do

	task :crawl => :environment do

		def complete_form body
			@doc = Nokogiri::HTML(body)

			hidden_inputs = @doc.css('input[type="hidden"]')

			post_params = {}
			hidden_inputs.each do |input|
				if !input.attribute("name").nil?
					attr_name = input.attribute("name").value
					if !input.attribute('value').nil?
						post_params[attr_name] = input.attribute("value").value
					end
				end
			end

			return post_params
		end


		def process_list body
			@doc = Nokogiri::HTML(body)

			ex_lis = @doc.css('ul.exercise-calories-list li')

			pb = ProgressBar.create
			pb.total = ex_lis.size
			puts "Got #{pb.total} exercises !!!"

			ex_lis.each do |ex|
				pb.increment

				begin
					# Exercise name
					ex_name = ex.css(".exercise-calories-list-right_A").first.css('.exercise-item-name').attribute('title').value

					# Exercise group
					ex_big_group = ex.css(".exercise-calories-list-right_A").first.css('.exercise-item-footer>div:not(.exercise-calories-list-width_A)>.food-type-name>a').attribute('title').value
					ex_group = ex.css(".exercise-calories-list-right_A").first.css('.exercise-item-footer>div.exercise-calories-list-width_A>.food-type-name>a').attribute('title').value
				rescue NoMethodError
					next
				end

				# 	puts "#{ex_name}\t\t - #{ex_group}"
				exercise = Exercise.find_by_name ex_name
				next if exercise

				bmg = MuscleGroup.find_by_name ex_big_group
				if !bmg
					bmg = MuscleGroup.create name: ex_big_group, muscle_group_id: nil
				end

				mg = MuscleGroup.find_by_name ex_group
				if !mg
					mg = MuscleGroup.create name: ex_group, muscle_group_id: bmg.id
				end

				exercise = Exercise.create name: ex_name
				exercise.exercise_muscle_groups.create muscle_group_id: mg.id, primary: true
			end
		end


		puts 'Getting login form...'
		res = HTTParty.get("https://secure.genesant.com/www/tf/main/Login.aspx?ms=1",
			:headers => {
				"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.111 Safari/537.36",
				"Content-Type" => "application/x-www-form-urlencoded",
				"Origin" => "https://secure.genesant.com",
				"Connection" => "keep-alive",
				"Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
				"Accept-Encoding" => "gzip, deflate, sdch"
				}
			)

			post_params = complete_form res.body
			post_params["login1$LoginName$login_name"] = "xbogdan"
			post_params["login1$password1$password"] = "bogdan5393"
			post_params['__EVENTTARGET'] = 'login1$LoginButton'
			post_params['fb-data'] = ''

			puts 'Logging in...'
			res = HTTParty.post("https://secure.genesant.com/www/tf/main/Login.aspx?ms=1",
				:body => post_params,
				:headers => {
					"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.111 Safari/537.36",
					"Content-Type" => "application/x-www-form-urlencoded",
					"Origin" => "https://secure.genesant.com",
					"Connection" => "keep-alive",
					"Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
					"Accept-Encoding" => "gzip, deflate, sdch"
				}
			)

			puts 'Setting cookie...'
			cookie = res.headers['set-cookie']

			puts 'Getting exercises from...'
			res = HTTParty.get("http://www.fitclick.com/exercises",
				:headers => {
					"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.111 Safari/537.36",
					"Content-Type" => "application/x-www-form-urlencoded",
					"Origin" => "https://secure.genesant.com",
					"Connection" => "keep-alive",
					"Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
					"Accept-Encoding" => "gzip, deflate, sdch",
					"Cookie" => cookie
				}
			)


			post_params = complete_form res.body
			post_params['__EVENTTARGET'] = 'logPager$HF'
			post_params['__EVENTARGUMENT'] =  'PS2000'
			post_params['txtSearchBox'] = ''
			post_params['logPager$HF'] = ''
			post_params['logPager$ctl24'] = 100
			post_params['logPager$ctl25'] = 100
			post_params['ddlBodyPart'] = -1
			post_params['ddlPMG'] = -1
			post_params['ddlCardioCat'] = -1
			post_params['ddlCreatedBy'] = 3

			puts 'Getting exercises...'
			res = HTTParty.post("http://www.fitclick.com/exercises?page=3",
				:body => post_params,
				:headers => {
					"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.111 Safari/537.36",
					"Content-Type" => "application/x-www-form-urlencoded",
					"Origin" => "https://secure.genesant.com",
					"Connection" => "keep-alive",
					"Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
					"Accept-Encoding" => "gzip, deflate, sdch",
					"Cookie" => cookie
				}
			)
			p res.response
			puts

			process_list res.body

		end
	end
